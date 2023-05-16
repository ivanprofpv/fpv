module ApplicationHelper
  RECAPTCHA_SITE_KEY = Rails.application.credentials[Rails.env.to_sym][:recaptcha][:site_key]

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
    comment_url = Comment.where('id = ?', comment).pluck(:drone_id)
  end

  def include_recaptcha_js
    raw %Q{
      <script src="https://www.google.com/recaptcha/api.js?render=#{RECAPTCHA_SITE_KEY}"></script>
    }
  end

  def recaptcha_execute(action)
    id = "recaptcha_token_#{SecureRandom.hex(10)}"

    raw %Q{
      <input name="recaptcha_token" type="hidden" id="#{id}"/>
      <script>
        grecaptcha.ready(function() {
          grecaptcha.execute('#{RECAPTCHA_SITE_KEY}', {action: '#{action}'}).then(function(token) {
            document.getElementById("#{id}").value = token;
          });
        });
      </script>
    }
  end
end
