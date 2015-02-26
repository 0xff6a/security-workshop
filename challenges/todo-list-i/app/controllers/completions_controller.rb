class CompletionsController < ApplicationController
  before_action :check_user_authenticated, :load_task
  def create
    @task.update_attributes(done: true)
    render nothing: true
  end

  def destroy
    @task.update_attributes(done: false)
    render nothing: true
  end

  private
  def load_task
    @task = current_user.tasks.find(params[:task_id])
  end
end
