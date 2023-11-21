class ApplicationController < ActionController::Base
  default_form_builder CustomFormBuilder

  include ErrorResponseActions

  def index
  end
end
