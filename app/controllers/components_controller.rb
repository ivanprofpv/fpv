class ComponentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_drone, only: %i[ create ]

  def new
    @component = Component.new
  end

  def show
    @components = Component.all
  end

  def create
    @component = @drone.components.new(component_params)

    @component.save
  end

  def destroy
    @component.destroy
  end

  private

  def component_params
    params.require(:component).permit(:title, :url, :price, :drone_id, :component_category_id)
  end

  def find_drone
    @drone = Drone.find(params[:drone_id])
  end

  def find_component
    @component = Component.find(params[:id])
  end
end
