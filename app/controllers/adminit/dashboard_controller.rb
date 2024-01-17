module Adminit
  class DashboardController < Adminit::ApplicationController
    def index
      authorize! :index?, with: Adminit::DashboardPolicy
    end
  end
end
