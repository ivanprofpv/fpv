class Admin::DashboardController < Admin::BaseController
  before_action :authenticate_user!

  def index
    @drones = Drone.all.order(created_at: :desc)
    @comments = Comment.all.order(created_at: :desc)
    @component_categories = ComponentCategory.all.order(created_at: :desc)
  end
end