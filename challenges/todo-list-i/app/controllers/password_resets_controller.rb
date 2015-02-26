class PasswordResetsController < ApplicationController
  before_action :load_token, :redirect_for_invalid_token

  def new
    @user = @token.user
  end

  def create
    @user = @token.user
    @token.user.tap do |user|
      user.password              = user_params[:password]
      user.password_confirmation = user_params[:password_confirmation]
      if user.save
        flash[:notice] = "Password reset successfully"
        redirect_to new_session_path
      else
        render 'new'
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation, :token)
  end

  def load_token
    token = params[:token] || params[:user][:token]
    @token = ResetPasswordToken.new(token)
  end

  def redirect_for_invalid_token
    load_token if @token.nil?
    unless @token.valid?
      flash[:error] = "Your reset password link is invalid, please generate a new one"
      redirect_to new_password_reset_request_path
    end
  end
end
