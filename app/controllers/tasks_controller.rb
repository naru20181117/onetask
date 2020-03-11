# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update)

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
      flash.now[:alert] = "Task名を確認して！!"
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @task.update(task_params)
      flash[:success] = "Task変更完了！"
      redirect_to tasks_path
    else
      redirect_to edit_task_path
      flash[:alert] = "Task変更失敗"
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :memo)
  end

  def set_task
    @task = Task.find_by(id: params[:id])
  end
end
