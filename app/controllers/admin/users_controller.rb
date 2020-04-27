# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update destroy)
  before_action :rescue403

  def index
    @users = User.eager_load(:tasks).order(created_at: :desc)
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "ユーザー【#{@user.name}】を登録しました。"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "ユーザー【#{@user.name}】を更新しました。"
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy ? flash[:notice] = "ユーザー【#{@user.name}】を削除しました。" : flash[:alert] = "少なくとも1つ、権限者アカウントが必要です"
    redirect_to admin_users_path
  end

  class Forbidden < ActionController::ActionControllerError
  end

  rescue_from Forbidden, with: :rescue403

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def rescue403
    render template: 'errors/forbidden', status: :forbidden unless current_user.admin?
  end
end
