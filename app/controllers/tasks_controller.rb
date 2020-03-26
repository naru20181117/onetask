# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy)
  before_action :set_variable, only: %i(index)

  def index
    @tasks = Task.select_desc(params[:created_at], params[:end_time])

  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = "もっとタスクを増やしていこう！"
      redirect_to @task
    else
      flash.now[:alert] = "Task作成失敗"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @task.update(task_params)
      flash[:success] = "Task変更完了！"
      redirect_to tasks_path
    else
      flash[:alert] = "Task変更失敗"
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = 'Deleted the task'
    redirect_to tasks_path
  end

  def set_variable
    @created_at_num = 0
    @end_time_num = 0
  end

  private

  def task_params
    params.require(:task).permit(:name, :memo, :end_time)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
