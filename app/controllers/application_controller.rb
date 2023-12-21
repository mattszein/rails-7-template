class ApplicationController < ActionController::Base
  default_form_builder CustomFormBuilder

  include Passwordless::ControllerHelpers
  helper_method :current_user

  include ErrorResponseActions

  before_action :set_sidebar_open

  def index
  end

  private

  def current_user
    @current_user ||= authenticate_by_session(User)
  end

  def require_user!
    return if current_user
    save_passwordless_redirect_location!(User) # <-- optional, see below
    redirect_to root_path, flash: {error: "You are not worthy!"}
  end

  def set_sidebar_open
    puts "set_sidebar_open"
    value = cookies["sidebar"]
    @sidebar_open = !value.nil? && value == "1"
  end
end
