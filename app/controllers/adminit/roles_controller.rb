module Adminit
  class RolesController < Adminit::ApplicationController
    before_action :set_role, only: [:remove_user, :add_user, :user_select]

    def index
      authorize!
      @roles = Role.all
    end

    def show
      @role = Role.includes(:users).find(params[:id])
      authorize!
    end

    def remove_user
      authorize! @role
      us = User.find(params[:user_id])
      us.role = nil
      if us.save
        flash[:notice] = "User was successfully removed from the role."
      else
        flash[:alert] = "User wasn't removed from the role."
      end
      redirect_to adminit_role_path(@role)
    end

    def user_select
      authorize!
    end

    def add_user
      authorize! @role
      user = User.find_by(email: role_params[:email])
      if user.role.nil?
        if user.update(role: @role)
          flash[:notice] = "User was successfully added to the role."
        else
          flash[:alert] = "User wasn't added to the role."
        end
      else
        flash[:alert] = "User already has a role."
      end
      redirect_to adminit_role_path(@role)
    end

    private

    def set_role
      @role = Role.find(params[:id])
    end

    def role_params
      params.require(:role).permit(:email)
    end
  end
end
