class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    if !@user
      redirect_to users_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to show_user_path(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    if !@user
      redirect_to users_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update
      redirect_to show_user_path(@user)
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).allow(:name) #, :username, :password)
    end
end
