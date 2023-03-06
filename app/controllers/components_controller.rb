class ComponentsController < ApplicationController
  before_action :authenticate_user!

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
end
