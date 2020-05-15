# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :login_required
  # rescue_from StandardError, with: :rescue500
  rescue_from ActiveRecord::RecordNotFound, with: :rescue404

  class Forbidden < ActionController::ActionControllerError
  end

  rescue_from Forbidden, with: :rescue403

  if Rails.env.production?
    http_basic_authenticate_with name: ENV['BASIC_AUTH_NAME'], password: ENV['BASIC_AUTH_PASSWORD']
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    redirect_to login_path unless current_user
  end

  def rescue403
    render template: 'errors/forbidden', status: :forbidden
  end

  def rescue404
    render file: 'public/404', status: :not_found, layout: false
  end

  def rescue500
    render file: 'public/500', status: :internal_server_error, layout: false
  end
end
