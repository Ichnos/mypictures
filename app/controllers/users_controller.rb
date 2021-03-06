class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def show    
    @user_pictures = @user.pictures.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @user = User.new
  end  
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{@user.username} to MyPictures App!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end  
  
  def edit
    
  end
  
  def update    
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to @user
    else
      render 'edit'
    end  
  end
  
  def destroy    
    @user.destroy
    flash[:danger] = "User and all associated pictures have been deleted"
    redirect_to users_path
  end

  
  
  private
  
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end


end
