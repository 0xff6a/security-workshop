class TasksController < ApplicationController
  before_action :check_user_authenticated
  def index
    @tasks = current_user.tasks
    @task = Task.new
  end

  def create
    unless current_user.tasks.create(task_params)
      flash[:error] = 'There was a problem creating the task'
    end
    redirect_to root_path
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.delete
    redirect_to root_path
  end

  private
  def task_params
    params[:task].permit(:description)
  end
end
