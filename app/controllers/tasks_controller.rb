# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy)
  before_action :set_variable, only: %i(index sort)

  def index
    @tasks = Task.order(created_at: :desc)
  end

  def sort
    if params[:created_at].present?
      @created_at_num = params[:created_at].to_i
      if @created_at_num.zero?
        @tasks = Task.order(created_at: :DESC)
        @created_at = '登録日時▼'
        @created_at_num = 1
      else
        @tasks = Task.order(created_at: :ASC)
        @created_at = '登録日時▲'
        @created_at_num = 0
      end

    elsif params[:end_time].present?
      @end_time_num = params[:end_time].to_i

      if @end_time_num.zero?
        @tasks = Task.order(end_time: :DESC)
        @end_time = '終了期限▼'
        @end_time_num = 1
      else
        @tasks = Task.order(end_time: :ASC)
        @end_time = '終了期限▲'
        @end_time_num = 0
      end

    else
      @tasks = Task.order(created_at: :desc)
    end
    render :index
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

  private

  def task_params
    params.require(:task).permit(:name, :memo, :end_time)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def set_variable
    @created_at = '登録日時△'
    @end_time = '終了期限△'
    @created_at_num = 0
    @end_time_num = 0
  end
end
