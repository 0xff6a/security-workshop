require 'active_support'
require 'base64'

module Helpers
  module Encryption
    # Assume default values
    ENCRYPTED_COOKIE_SALT        =  "encrypted cookie" 
    ENCRYPTED_SIGNED_COOKIE_SALT =  "signed encrypted cookie"

    def decrypt_session_cookie(cookie, secret_key_base)
      cookie = CGI.unescape(cookie)
      encryptor(secret_key_base).decrypt_and_verify(cookie)
    end

    def encrypt_session_cookie(cookie, secret_key_base)
      cookie = encryptor(secret_key_base).encrypt_and_sign(cookie)
      CGI.escape(cookie)
    end

    private

    def encryptor(secret_key_base)
      # Create keys
      key_generator = ActiveSupport::KeyGenerator.new(secret_key_base, iterations: 1000)
      secret        = key_generator.generate_key(ENCRYPTED_COOKIE_SALT)
      sign_secret   = key_generator.generate_key(ENCRYPTED_SIGNED_COOKIE_SALT)

      # Build Encryptor
      ActiveSupport::MessageEncryptor.new(secret, sign_secret)
    end
  end
end