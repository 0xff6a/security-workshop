class AdminController < ApplicationController
  before_filter :authenticate_user!

  def index
    redirect_to tasks_path unless current_user.admin?
  end
end
