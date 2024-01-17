module Adminit
  class Passwordless::SessionResourcePolicy < ApplicationPolicy
    def index?
      user.is_admin?
    end
  end
end
