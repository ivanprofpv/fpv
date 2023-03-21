module ProfilesHelper
  def count_drone_user
    @drone_user = Drone.where('user_id = ?', @profile)
    @drone_user.size
  end

  def count_comment_user
    @comment_user = Comment.where('user_id = ?', @profile)
    @comment_user.size
  end

  def username
    @user_name = User.where('id = ?', @profile).pluck(:username)
    @user_name.join()
  end
end
