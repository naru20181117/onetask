# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy done)
  # before_action :params_permit, only: %i(index)

  def index
    @tasks = if params["search"].nil?
               Task.select_desc(sort_column)
             else
               Task.select_desc(sort_column)
                   .search_task(content_params)
                   .search_status(status_params)
             end
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

  def done
    @task.done!
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:name, :memo, :end_time, :status)
  end

  def search_params
    params.require(:task).permit(:name, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def sort_column
    %w[created_at end_time priority].include?(params[:sort_column]) ? params[:sort_column] : "created_at"
  end

  def content_params
    params["search"].permit!["content"]
  end

  def status_params
    params["search"].permit!["status"]
  end
end
