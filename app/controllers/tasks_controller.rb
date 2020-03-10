# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_list

  def index
    @tasks = Task.all
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
      flash.now[:alert] = "Task名を入力して！!"
      render new_task_path
    end
  end

  def show; end

  def edit; end

  def update
    @task = Task.find_by(id: params[:id])
    if @task.update(task_params)
      flash[:success] = "Task変更完了！"
      redirect_to tasks_path
    else
      flash.now[:alert] = "Task変更失敗"
      render edit_task_path
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :memo)
  end

  def set_list
    @task = Task.find_by(id: params[:id])
  end
end
