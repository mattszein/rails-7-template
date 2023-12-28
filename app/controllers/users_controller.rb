class UsersController < ApplicationController
  include Passwordless::ControllerHelpers

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @session = build_passwordless_session(@user)
      if @session.save
        if Passwordless.config.after_session_save.arity == 2
          Passwordless.config.after_session_save.call(@session, request)
        else
          Passwordless.config.after_session_save.call(@session)
        end
        redirect_to(
          Passwordless.context.path_for(
            @session,
            id: @session.to_param,
            action: "show"
          ),
          flash: {notice: I18n.t("passwordless.sessions.create.email_sent")}
        )
      else
        flash[:error] = I18n.t("passwordless.sessions.create.error")
        render(:new, status: :unprocessable_entity)
      end
    else
      render(:new)
    end
  end

  def policies
  end

  private

  def user_params
    params.require(:user).permit(:username, :email)
  end
end
