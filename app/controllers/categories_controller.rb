class CategoriesController < ApplicationController
  def new
    @category=Category.new
  end

  def create
    @category=Category.new(category_params)
    if @category.save
      flash[:notice] = "Category Created"
      redirect_to categories_path
    else
      flash[:alert]=@category.errors.full_messages.join(',')
      redirect_to new_category_path
    end
  end

  def edit
    @category=Category.find(params[:id])
  end

  def update
    @category=Category.find(params[:id])

    if @category.update(category_params)
      flash[:notice] = "Category Updated"
      redirect_to categories_path
    else
      flash[:alert]=@category.errors.full_messages.join(',')
      redirect_to edit_category_path
    end
  end

  def destroy
    @category=Category.find(params[:id])

    if @category.destroy
      flash[:notice] = "Category Deleted"
      redirect_to categories_path
    else
      flash[:alert]=@category.errors.full_messages.join(',')
      redirect_to root_path
    end
  end

  def index
    if params[:search]
      @categories =Category.search(params[:search]).all.order("created_at DESC").paginate(:per_page => 10, :page => params[:page])
    else
      @categories =Category.all.order("created_at DESC").paginate(:per_page => 10, :page => params[:page])
    end
  end

  def show
    @category=Category.find(params[:id])
    @images=Image.find_by_category(@category)
    @categories=Category.all
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end
end
