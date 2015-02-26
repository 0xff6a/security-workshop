class HomeController < ApplicationController
  before_filter :authenticate_user!
  def index
    redirect_to organisation_path(current_user.organisation)
  end
end
