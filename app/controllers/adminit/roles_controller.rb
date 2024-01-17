module Adminit
  class RolesController < Adminit::ApplicationController
    before_action :set_role, only: [:show, :remove_user, :user_select, :add_user]

    def index
      authorize!
      @roles = Role.all
    end

    def show
    end

    def remove_user
      authorize! @role
      us = User.find(params[:user_id])
      @role.users.delete(us)
      redirect_to adminit_role_path(@role), flash: {notice: "Role was successfully deleted."}
    end

    def user_select
      @users = User.all
    end

    def add_user
      u = User.find_by(email: role_params[:email])
      ru = RolesUser.new(role_id: @role.id, user_id: u.id)

      flash[:notice] = if ru.save
        "User was successfully added to the role."
      else
        "User wasn't added to the role."
      end
      redirect_to adminit_role_path(@role)
    end

    private

    def set_role
      @role = Role.includes(:users).find(params[:id])
    end

    def role_params
      params.require(:role).permit(:email)
    end
  end
end
