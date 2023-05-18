class GalleriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_drone, only: %i[create]

  def create
    @gallery = @drone.galleries.new(gallery_params)

    @gallery.save
  end

  def show
  end

  def destroy
  end

  private

  def gallery_params
    params.require(:gallery).permit(:drone_id, :gallery_foto)
  end

  def find_drone
    @drone = Drone.find(params[:drone_id])
  end
end
