require 'base64'
require 'openssl'

class ResetPasswordToken
  def initialize(token)
    decoded = ResetPasswordToken.decrypt(Base64.urlsafe_decode64(token))
    @token = token
    @email, @expires = decoded.split('&').map { |item| item.split('=')[1] }
  end

  def valid?
     self.user && Time.now.to_i < @expires.to_i
  end

  def user
    @user ||= User.find_by_email(@email)
  end

  def to_s
    @token
  end

  class << self
    def generate_for(user, expiry = 30.minutes.from_now)
      ResetPasswordToken.new(
        Base64.urlsafe_encode64(
          ResetPasswordToken.encrypt([
            ['email', user.email].join('='),
            ['expires', 30.minutes.from_now.to_i].join('=')]
            .join('&')
          )
        )
      )
    end

    def encrypt(plaintext)
      encrypter   = cipher 'encrypt'
      ciphertext  = encrypter.update(plaintext)
      ciphertext += encrypter.final
    end

    def decrypt(plaintext)
      decrypter  = cipher 'decrypt'
      plaintext  = decrypter.update(plaintext)
      plaintext += decrypter.final
    end

    def cipher(direction)
      OpenSSL::Cipher::AES128.new('ECB').tap do |c|
        c.send(direction)
        c.key = 'CHEESE ON TOASTY'
      end
    end
  end
end
