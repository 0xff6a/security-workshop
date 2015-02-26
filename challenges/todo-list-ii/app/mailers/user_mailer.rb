class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def password_reset_email(user)
    @user = user
    @password_reset_url = new_password_reset_url(
      host: 'localhost:3000', 
      token: ResetPasswordToken.generate_for(user)
    )
    mail to: user.email, subject: 'Password Reset Email'
  end
end
