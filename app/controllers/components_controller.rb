class ComponentsController < ApplicationController
  before_action :authenticate_user!
  # before_action :find_drone, only: %i[ create ]

  # def create
  #   byebug
  #   @component = @drone.components.create(component_params.merge(current_user))
  #
  # end

  def destroy
    @component.destroy
  end

  private

  def find_drone
    @drone = Drone.find(params[:drone_id])
  end

  def find_component
    @component = Component.find(params[:id])
  end

  def component_params
    params[:component].permit(:title, :url, :price, :drone_id)
  end
end
