class ApplicationController < ActionController::Base
  default_form_builder CustomFormBuilder
  include AuthenticationConcern
  include ErrorResponseActions
  helper_method :current_user
  before_action :set_sidebar_open

  def index
  end

  private

  def set_sidebar_open
    value = cookies["sidebar"]
    @sidebar_open = !value.nil? && value == "1"
  end
end
