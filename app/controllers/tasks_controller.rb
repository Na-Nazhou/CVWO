class TasksController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @tasks = @user.tasks
    if params[:q]
        @tasks = @user.tasks.where(tag: params[:q])
    end
  end

  def show
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @task = @user.tasks.build
  end

  def edit
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
  end

  def create
    @user = User.find(params[:user_id])
    @task = @user.tasks.create(task_params)
    if @task.save
      redirect_to user_tasks_path(@user)
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to user_tasks_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
    @task.destroy
    redirect_to user_tasks_path(@user)
  end

  private
    def task_params
      params.require(:task).permit(:title, :description, :deadline, :tag)
    end
end
