# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  if Rails.env.production?
    http_basic_authenticate_with name: ENV['BASIC_AUTH_NAME'], password: ENV['BASIC_AUTH_PASSWORD']
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
