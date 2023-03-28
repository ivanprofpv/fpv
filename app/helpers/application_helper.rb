module ApplicationHelper
  def current_year
    Time.current.year
  end

  def all_count_drone_admin
    drone_user = Drone.all
    drone_user.size
  end

  def all_count_comment_admin
    comment_user = Comment.all
    comment_user.size
  end

  def url_drone_for_list_comment_admin(comment)
    comment_url = Comment.where(id: comment).pluck(:drone_id)
  end
end
