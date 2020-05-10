# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update destroy)
  before_action :require_admin

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
      redirect_to admin_users_path, flash: { success: "ユーザー【#{@user.name}】を登録しました。" }
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), flash: { success: "ユーザー【#{@user.name}】を更新しました。" }
    else
      render :edit
    end
  end

  def destroy
    unless @user.destroy
      flash.alert = @user.errors.full_messages[0]
      redirect_to admin_users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_admin
    raise Forbidden unless current_user.admin?
  end
end
