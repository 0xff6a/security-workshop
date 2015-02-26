class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    redirect_to edit_user_path(user)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    self.current_user = @user
    redirect_to entries_path
  end

  private
  def user_params
    params.require(:user).permit(:email, :name, :password, :medications)
  end
end
