class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = current_user.organisation.users
  end

  def show
    @user = User.find(params[:id])
    @payments = @user.payments
    redirect_to :root unless can? :read, @user
  end

end
