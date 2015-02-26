class SecretsController < ApplicationController
  before_filter :load_secret, :require_logged_in_user

  def show
  end

  def edit
  end

  def update
    if current_user && current_user.secret == @secret
      @secret.update_attributes secret_params
    end

    redirect_to secret_path(@secret)
  end

  private
  def load_secret
    @secret = Secret.find(params[:id])
  end

  def secret_params
    params.require(:secret).permit(:content)
  end
end
