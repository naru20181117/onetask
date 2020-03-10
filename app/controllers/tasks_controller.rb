# frozen_string_literal: true

class TasksController < ApplicationController
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
      render 'new'
      flash[:alert] = 'もっとタスクを増やしていこう!'
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
    if @task.update(task_params)
      flash[:success] = "Task変更完了！"
      redirect_to :root
    else
      render action: :edit
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :memo)
  end
end
