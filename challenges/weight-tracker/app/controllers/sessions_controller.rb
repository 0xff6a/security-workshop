class SessionsController < ApplicationController
  def new
  end

  def create
    if (user = User.authenticate(*session_params.values_at(:email, :password)))
      self.current_user = user
      redirect_to entries_path
    else
      flash[:error] = "Couldn't authenticate successfully"
      redirect_to new_session_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
