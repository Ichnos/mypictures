class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update]
  
  def index
    @pictures = Picture.paginate(page: params[:page], per_page: 5)
  end 
  
  def show
    
  end
  
  def new
    @picture = Picture.new
  end
  
  def create
    @picture = Picture.new(picture_params)
    @rpicture.user = current_user
    if @picture.save
      flash[:success] = "Picture was created successfully!"
      redirect_to pictures_path(@picture)
    else
      render 'new'
    end
  end  
  
  def edit
    
  end
  
  def update
    if @picture.update(picture_params)
      flash[:success] = "Picture was updated successfully!"
      redirect_to picture_path(@picture)
    else
      render 'edit'
    end
  end 
  
  def destroy
    Picture.find(params[:id]).destroy
    flash[:success] = "Picture deleted successfully"
    redirect_to pictures_path
  end 
   
  private
  
    def set_picture
      @picture = Picture.find(params[:id])
    end  
  
    def picture_params
      params.require(:picture).permit(:name, :description)
    end
  end
