class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end  
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome #{@user.username} to MyPictures App!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end  
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to @user
    else
      render 'edit'
    end  
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end