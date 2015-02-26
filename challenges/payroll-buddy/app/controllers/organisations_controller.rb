class OrganisationsController < ApplicationController
  def show
    @users = current_user.organisation.users
  end
end
