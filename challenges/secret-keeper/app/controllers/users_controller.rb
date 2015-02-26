class UsersController < ApplicationController
  before_filter :require_logged_in_user
  def index
    @users = User.all
  end
end
