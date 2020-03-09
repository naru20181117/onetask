# frozen_string_literal: true

class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def show
    @task = Task.find(params[:id])
  end

  def index
    @tasks = Task.all
  end
end
