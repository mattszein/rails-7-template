module Adminit
  class ApplicationController < ActionController::Base
    default_form_builder CustomFormBuilder
    include AuthenticationConcern
    helper_method :current_user

    rescue_from ActionPolicy::Unauthorized do |ex|
      msg = I18n.t("adminit.authorization.unauthorized")
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.update("flashes_id", partial: "shared/flash", locals: {msg: msg})
        }
        format.html { redirect_to "/", flash: {alert: msg} }
      end
    end
    before_action :authorize_adminit_access

    def authorize_adminit_access
      redirect_to "/", flash: {alert: "You are not worthy!"} unless current_user&.adminit_access?
    end
  end
end
