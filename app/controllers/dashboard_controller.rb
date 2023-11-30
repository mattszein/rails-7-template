class DashboardController < ApplicationController
  before_action :require_user!

  def index
    @username = current_user.username
  end
end
