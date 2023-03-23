class ComponentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_drone, only: %i[create]
  before_action :find_component, only: %i[update edit destroy]

  def new
    @component = Component.new
  end

  def show
    @components = Component.all
  end

  def create
    @component = @drone.components.new(component_params)
    authorize @component

    @component.save
  end

  def update
    authorize @component
    @drone = @component.drone
    @component.update(component_params)
  end

  def edit; end

  def destroy
    authorize @component
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
