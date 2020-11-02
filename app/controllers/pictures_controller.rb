class PicturesController < ApplicationController
  def index
    @pictures = Picture.all
  end
  
  def show
    @picture = Picture.find(params[:id])
  end

  def new  
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(recipe_params)
    @picture.user = User.first
    if @picture.save
      flash[:success] = "Picture was created successfully!"
      redirect_to picture_path(@picture)
    else
      render 'new'
    end
  end
  private
    def picture_params
      params.require(:picture).permit(:name, :description)
    end
  end
