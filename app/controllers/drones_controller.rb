class DronesController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy edit new]
  before_action :load_drone, only: [:show, :edit, :update, :destroy, :upvote]

  def index
    @drones = Drone.all.order(created_at: :desc)
  end

  def upvote
    if current_user.voted_up_on? @drone
      @drone.unvote_by current_user
    else
      @drone.upvote_by current_user
    end
    render "vote.js.erb"
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
    @drone = Drone.with_attached_foto.with_attached_gallerys.find(params[:id])
  end

  def drone_params
    params.require(:drone).permit(:title, :body, :content, :foto, :category_id, gallerys: [])
  end
end
