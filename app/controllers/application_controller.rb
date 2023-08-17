require 'net/http'

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  RECAPTCHA_MINIMUM_SCORE = 0.5

  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def verify_recaptcha?(token, recaptcha_action)
    secret_key = Rails.application.credentials[Rails.env.to_sym][:recaptcha][:secret_key]

    uri = URI.parse("https://www.google.com/recaptcha/api/siteverify?secret=#{secret_key}&response=#{token}")
    response = Net::HTTP.get_response(uri)
    json = JSON.parse(response.body)
    json['success'] && json['score'] > RECAPTCHA_MINIMUM_SCORE && json['action'] == recaptcha_action
  end

  private

  def configure_permitted_parameters
    added_attrs = %i[username email password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: %i[login password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:username, :email, :password, :password_confirmation, :admin)
    end
  end

  def user_not_authorized
    flash[:alert] = "No rights to perform this action"
    redirect_back(fallback_location: root_path)
  end
end
