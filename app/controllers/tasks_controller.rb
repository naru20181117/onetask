# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy done)

  def index
    @tasks = if params["search"].nil?
               Task.preload(:labels)
                   .where(user: current_user)
                   .select_asc(sort_column)
                   .page(params[:page])
                   .where.not(status: "done")
             else
               Task.preload(:labels)
                   .where(user: current_user)
                   .select_asc(sort_column)
                   .search_task(content_params)
                   .search_status(status_params)
                   .search_label(label_params)
                   .page(params[:page])
                   .where.not(status: "done")
             end

    respond_to do |format|
      format.html
      format.csv do
        send_data current_user.tasks.all.generate_csv, filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv"
      end
    end

    @done_tasks = current_user.tasks.where(status: "done").order(updated_at: :desc).page(params[:page])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      TaskMailer.creation_email(@task).deliver_now
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
    @task.status = 'done'
    @task.save(validation: false)
    redirect_to tasks_path
  end

  def import
    current_user.tasks.import(params[:file])
    redirect_to tasks_url, notice: 'タスクを追加しました'
  end

  private

  def task_params
    params.require(:task).permit(:name, :memo, :end_time, :status, :priority, { label_ids: [] }, :content)
  end

  def search_params
    params.require(:task).permit(:name, :status)
  end

  def set_task
    @task = if current_user.admin?
              Task.find(params[:id])
            else
              current_user.tasks.find(params[:id])
            end
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
