
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :name, :photo) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :name, :photo) }
  end
  
  def after_sign_in_path_for(user)
    origin_path = session[:origin_path]
    clear_origin_path
    if origin_path.present?
      origin_path
    else
      params[:target].presence || default_redirect_path
    end
  end

  private

  def authenticate_user!
    store_origin_path
    super
  end

  def store_origin_path
    session[:origin_path] = request.fullpath
  end

  def clear_origin_path
    session[:origin_path] = nil
  end

end