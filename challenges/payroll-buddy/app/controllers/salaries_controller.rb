class SalariesController < ApplicationController
  before_filter :authenticate_user!
  def update
    user = User.find(salary_params[:user_id])
    if current_user.manages?(user.organisation)
      user.salary = salary_params[:amount].to_i
      user.save
      redirect_to user_path user
    else
      redirect_to user_path current_user
    end
  end

  private

  def salary_params
    params[:salary].slice :user_id, :amount
  end

end
