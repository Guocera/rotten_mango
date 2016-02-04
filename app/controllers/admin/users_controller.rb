class Admin::UsersController < ApplicationController
  before_action :admin_access

  def index
    @users = User.all.page(params[:page]).per(2)
  end

  def create
  end

  def new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def update
  end

  def destroy
    @user = User.find(params[:id])
    session[:user_id] = nil if session[:user_id] == @user.id
    @user.destroy
    redirect_to admin_users_path
  end
end
