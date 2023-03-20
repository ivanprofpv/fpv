module ProfilesHelper
  def count_drone_user
    @drone_user = Drone.where(user_id: current_user)
    @drone_user.size
  end

  def count_comment_user
    @comment_user = Comment.where(user_id: current_user)
    @comment_user.size
  end
end
