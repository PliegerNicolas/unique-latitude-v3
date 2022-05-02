class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    before_action :authenticate_user!, except: [:index, :show]
    before_action :configure_permitted_parameters, if: :devise_controller?

    include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    # Pundit: white-list approach.
    after_action :verify_authorized, except: :index, unless: :skip_pundit?
    after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?
  
    # Uncomment when you *really understand* Pundit!
    # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    # def user_not_authorized
    #   flash[:alert] = "You are not authorized to perform this action."
    #   redirect_to(root_path)
    # end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  # Redirect after login via Devise
  def after_sign_in_path_for(resource)
    session["user_return_to"] || root_path
  end

  # Redirect if unauthorized by Pundit
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    session["user_return_to"] = redirection_reroll
    redirect_to(session["user_return_to"] || root_path)
  end

  # Reroll redirection path when unauthorized
  def redirection_reroll
    session["user_return_to"] ||= request.path
    path_checker = ["new", "edit"]
    path = session["user_return_to"].split("/")
    path.pop() if path_checker.include? path[-1]
    session["user_return_to"] = path.join("/")
  end
end
