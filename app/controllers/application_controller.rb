class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # CanCan
  check_authorization unless: :skip_authorization?
  rescue_from CanCan::AccessDenied, with: :access_denied

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def skip_authorization?
    devise_controller?
  end

  # Called by CanCan
  def access_denied(ex)
    Rails.logger.debug { "--- access_denied #{ex.action}, #{ex.subject.class}:#{ex.subject.try(:id) || ex.subject.inspect}" }

    if request.xhr?
      render json: { message: t('devise.failure.access_denied') }, status: :forbidden
    else
      if current_user.nil?
        redirect_to authenticate_user!, alert: t('devise.failure.unauthenticated')
      else
        flash[:alert] = t('devise.failure.access_denied')
        redirect_to main_app.root_url
      end
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
    # devise_parameter_sanitizer.permit :sign_up, keys: [:name]
    # devise_parameter_sanitizer.permit :account_update, keys: [:name]
  end

  def log_error(ex)
    Rails.logger.error ex.inspect
    Rails.logger.error ex.backtrace.join("\n")
  end
end
