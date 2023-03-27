module ApplicationHelper
  def current_year
    Time.current.year
  end

  def all_count_drone
    drone_user = Drone.all
    drone_user.size
  end

  def all_count_comment
    comment_user = Comment.all
    comment_user.size
  end
end
