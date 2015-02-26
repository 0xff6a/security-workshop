require 'base64'
class ResetPasswordToken
  def initialize(token)
    decoded = Base64.urlsafe_decode64(token)
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
        Base64.urlsafe_encode64([
          ['email', user.email].join('='), 
          ['expires', 30.minutes.from_now.to_i].join('=')]
          .join('&')
        )
      )
    end
  end
end
