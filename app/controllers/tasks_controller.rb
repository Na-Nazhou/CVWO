class TasksController < ApplicationController
before_action :correct_user

  def index
    @user = User.find(params[:user_id])
    @tasks = @user.tasks.order(deadline: :desc).paginate(page: params[:page])
    @tags = @user.tags
    if params[:q]
        @tag = @tags.where(tag_name: params[:q])
    end
    @ongoing_tasks = @tasks.where(completed: false)
    @completed_tasks = @tasks.where(completed: true)
  end

  def show
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @task = @user.tasks.build
    @tag = @task.tags.build
  end

  def edit
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
    @tags = @task.tags
  end

  def create
    @user = User.find(params[:user_id])
    @task = @user.tasks.create(task_params)
    params[:task][:tags][:tag_name].each do |tag_name|
      @task.tags.create(tag_name: tag_name)
    end
    if @task.save
      flash[:success] = "Task added!"
      redirect_to user_tasks_url
    else
      render 'new'
    end
  end

  def complete
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
    @task.update(completed: true)
    flash[:sucess] = "Task completed!"
    redirect_to user_tasks_url
  end

  def uncomplete
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
    @task.update(completed: false)
    flash[:sucess] = "Task not completed!"
    redirect_to user_tasks_url
  end

  def update
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
    params[:task][:tags][:tag_name].each do |tag_name|
      @task.tags.create(tag_name: tag_name)
    end
    if @task.update(task_params)
      flash[:success] = "Task updated!"
      redirect_to user_tasks_url
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
    @task.destroy
    flash[:success] = "Task deleted!"
    redirect_to user_tasks_path(@user)
  end

  private
    def task_params
      params.require(:task).permit(:title, :description, :deadline)
    end

    # Confirms a logged_in user_
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user
    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
