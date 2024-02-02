module Authentication
  class Unauthenticated < StandardError
  end
  extend ActiveSupport::Concern
  include Passwordless::ControllerHelpers

  private

  def current_user
    @current_user ||= authenticate_by_session(User)
  end

  def require_user!
    return if current_user
    save_passwordless_redirect_location!(User) # <-- optional, see below
    msg = I18n.t("authentication.unauthenticated")
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.update("flashes_id", partial: "shared/flash", locals: {msg: msg})
      }
      format.html { redirect_to users_sign_in_path, flash: {alert: msg} }
    end
  end
end
