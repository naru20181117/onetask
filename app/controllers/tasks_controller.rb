# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy done)

  def index
    @tasks = if params["search"].nil?
               Task.preload(:labels)
                   .where(user: current_user)
                   .select_desc(sort_column)
                   .page(params[:page])
             else
               Task.preload(:labels)
                   .where(user: current_user)
                   .select_desc(sort_column)
                   .search_task(content_params)
                   .search_status(status_params)
                   .search_label(label_params)
                   .page(params[:page])
             end
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to @task, flash: { success: "もっとタスクを増やしていこう！" }
    else
      flash.now[:alert] = "Task作成失敗"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, flash: { success: "Task変更完了！" }
    else
      flash.alert = "Task変更失敗"
      render :edit
    end
  end

  def destroy
    @task.destroy
    head :no_content
  end

  def done
    @task.done!
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:name, :memo, :end_time, :status, :priority, { label_ids: [] })
  end

  def search_params
    params.require(:task).permit(:name, :status)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def sort_column
    %w[created_at end_time status priority].include?(params[:sort_column]) ? params[:sort_column] : "created_at"
  end

  def content_params
    params["search"].permit!["content"]
  end

  def status_params
    params["search"].permit!["status"]
  end

  def label_params
    params["search"].permit!["label"]
  end
end
