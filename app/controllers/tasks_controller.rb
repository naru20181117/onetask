# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
    @task.save
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      logger.debug "task: #{@task.attributes.inspect}"
      flash[:success] = "もっとタスクを増やしていこう！"
      redirect_to @task
    else
      render 'new'
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    @task = Task.find_by(id: params[:id])
    @task.update(task_params)
    redirect_to :root
  end

  private

  def task_params
    params.require(:task).permit(:name, :memo)
  end
end
