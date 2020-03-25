# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_variable, only: %i(index sort)
  before_action :basic_auth, if: :production?
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

  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    http_basic_authenticate_with name: ENV['BASIC_AUTH_NAME'], password: ENV['BASIC_AUTH_PASSWORD']
  end

  def set_variable
    @created_at = '登録日時△'
    @end_time = '終了期限△'
    @created_at_num = 0
    @end_time_num = 0
  end
end
