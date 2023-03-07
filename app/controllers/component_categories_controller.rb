class ComponentCategoriesController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy edit]
  before_action :load_component_category, only: [:show, :update, :destroy, :edit]

  def index
    @component_category = ComponentCategory.all
  end

  def show
  end

  def new
    @component_category = ComponentCategory.new
  end

  def create
    @component_category = ComponentCategory.new(component_category_params)

    if @component_category.save
      flash[:good] = "Category component created successfully."
      redirect_to new_component_category_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @component_category.update(component_category_params)
      flash[:good] = "Category component updated successfully."
      redirect_to @component_category
    else
      render :edit
    end
  end

  def destroy
    @component_category.destroy
    flash[:good] = "Category component deleted successfully."
    redirect_to root_path
  end

  private

  def load_component_category
    @component_category = ComponentCategory.find(params[:id])
  end

  def component_category_params
    params.require(:component_category).permit(:title)
  end
end
