module Adminit
  class ApplicationController < ActionController::Base
    default_form_builder CustomFormBuilder
    include Authentication
    helper_method :current_user
    before_action :require_user!
    before_action :authorize_adminit_access

    rescue_from ActionPolicy::Unauthorized do |ex|
      msg = I18n.t("adminit.authorization.unauthorized")
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.update("flashes_id", partial: "shared/flash", locals: {msg: msg})
        }
        format.html { redirect_to "/", flash: {alert: msg} }
      end
    end

    def authorize_adminit_access
      redirect_to "/", flash: {alert: "You are not worthy!"} unless current_user&.adminit_access?
    end

    private

    def ensure_frame_response
      redirect_to root_path unless turbo_frame_request?
    end
  end
end
