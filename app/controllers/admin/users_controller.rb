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
  end

  def show
    @user = User.find(params[:id])
  end

  def update
  end

  def destroy
  end
end
