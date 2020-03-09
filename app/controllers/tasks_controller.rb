# frozen_string_literal: true

class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def show
    @task = Task.find(params[:id])
    # render :text => "id =#{params[:id]}"
  end

  def list
    @tasks = Task.all
  end
end
