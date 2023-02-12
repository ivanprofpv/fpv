class CategoriesController < ApplicationController
  before_action :load_category, only: [:show]

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:good] = "Category created successfully."
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @category.destroy
    flash[:good] = "Category deleted successfully."
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
