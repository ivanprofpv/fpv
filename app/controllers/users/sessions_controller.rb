class Users::SessionsController < Devise::SessionsController
  prepend_before_action :verify_log_in, only: %i[create]

  private

  def verify_log_in
    return if verify_recaptcha?(params[:recaptcha_token], 'captcha')

    self.resource = resource_class.new sign_in_params

    respond_with_navigational(resource) do
      flash.now[:error] = "reCAPTCHA Authorization Failed. Please try again later."
      render :new
    end
  end
end
