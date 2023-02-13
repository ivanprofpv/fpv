class DronesController < ApplicationController
  before_action :load_drone, only: [:show, :edit, :update, :destroy]

  def index
    @drones = Drone.all
  end

  def show
    @load_category = load_drone.category_id
    @category_cat = Category.find(@load_category)
  end

  def new
    @drone = Drone.new
  end

  def create
    @drone = Drone.new(drone_params)

    @drone.user = current_user

    if @drone.save
      flash[:good] = "Drone created successfully."
      redirect_to @drone
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @drone.update(drone_params)
      flash[:good] = "Drone updated successfully."
      redirect_to @drone
    else
      render :edit
    end
  end

  def destroy
    @drone.destroy
    flash[:good] = "Drone deleted successfully."
    redirect_to root_path
  end

  private

  def load_drone
    @drone = Drone.with_attached_foto.find(params[:id])
  end

  def drone_params
    params.require(:drone).permit(:title, :body, :content, :foto, :category_id)
  end
end
