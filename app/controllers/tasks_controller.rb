# frozen_string_literal: true

class TasksController < ApplicationController
  def new
  end

  def show
    @task = Task.new
  end
end
