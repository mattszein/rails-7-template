class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(create_passwordless_session(@user)) # <-- This!
      redirect_to(@user, flash: {notice: "Welcome!"})
    else
      render(:new)
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email)
  end
end
