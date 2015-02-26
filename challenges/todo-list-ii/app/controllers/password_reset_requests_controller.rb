require 'json'
class PasswordResetRequestsController < ApplicationController
  def new
  end

  def create
    if user = User.find_by_email(params[:email])
      # send the email
      UserMailer.password_reset_email(user).deliver unless user.dummy?
      redirect_to new_session_path, flash: {notice: "Instructions for resetting you password have been emailed to #{params[:email]}."}
    else
      redirect_to new_password_reset_request_path, flash: { error: "No user with email '#{params[:email]}' found."}
    end
  end
end
