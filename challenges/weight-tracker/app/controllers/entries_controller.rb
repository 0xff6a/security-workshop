class EntriesController < ApplicationController
  before_filter :require_login

  def index
    current_user.tap do |u|
      @entries, @medications, @secret = u.entries, u.medications, u.secret
    end
  end
end
