class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image=Image.new(image_param)
    if @image.save
      flash[:notice] = "Category Created"
      redirect_to images_path
    else
      flash[:alert]=@image.errors.full_messages.join(',')
      redirect_to new_image_path
    end
  end

  def destroy
    @image=Image.find(params[:id])

    if @image.destroy
      flash[:notice] = "Image Deleted"
      redirect_to images_path
    else
      flash[:alert]=@image.errors.full_messages.join(',')
      redirect_to images_path
    end
  end

  def home
    @categories=Category.all
    @images=Image.all
  end

  def index
    if params[:search]
      @images =Image.search(params[:search]).all.order("created_at DESC").paginate(:per_page => 10, :page => params[:page])
    else
      @images =Image.all.order("created_at DESC").paginate(:per_page => 10, :page => params[:page])
    end
  end
  private
    def image_param
      params.require(:image).permit(:image, :category_id, :image_title, :image_description, :image_file_size, :image_content_type, :remote_image_url)
    end
end
