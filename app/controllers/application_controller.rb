class ApplicationController < ActionController::Base
  include Pundit::Authorization
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  # Redirect if unauthorized by Pundit
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    # session["user_return_to"] = redirection_reroll
    # redirect_to(session["user_return_to"] || root_path)
    redirect_back(fallback_location: root_path)
  end

  # Reroll redirection path when unauthorized
  # /!\ This method isn't perfectly working /!\
  # def redirection_reroll
  #   session["user_return_to"] ||= request.path
  #   path_checker = ["new", "edit"]
  #   path = session["user_return_to"].split("/")
  #   path.pop() if path_checker.include? path[-1]
  #   session["user_return_to"] = path.join("/")
  # end

    # Redirect after login via Devise
    # def after_sign_in_path_for(resource)
    #   session["user_return_to"] || root_path
    # end

  protected

  # Configure User parameters for Devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
