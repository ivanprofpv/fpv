class Admin::DashboardController < Admin::BaseController
  before_action :authenticate_user!

  def index
    @drones = Drone.all.order(created_at: :desc)
    @comments = Comment.all.order(created_at: :desc)
  end

  private

  def find_url_comment
    @comment_url = Comment.where(id: comment).pluck(:drone_id)
  end
end