class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy edit]
  before_action :load_category, only: %i[show update destroy edit]

  def index
    @categories = Category.all
  end

  def show; end

  def new
    @category = Category.new
  end

  def create
    authorize Category
    @category = Category.new(category_params)

    if @category.save
      flash[:good] = 'Category created successfully.'
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    authorize @category
    if @category.update(category_params)
      flash[:good] = 'Category updated successfully.'
      redirect_to @category
    else
      render :edit
    end
  end

  def destroy
    authorize @category
    @category.destroy
    flash[:good] = 'Category deleted successfully.'
    redirect_to root_path
  end

  private

  def load_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title)
  end
end
