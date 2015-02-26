class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private
  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue
      nil
    end
  end
  helper_method :current_user

  def secret
    @secret ||= File.read(Rails.root.join('secret'))
  end
  helper_method :secret

  def check_user_authenticated
    redirect_to new_session_path unless current_user
  end
end
