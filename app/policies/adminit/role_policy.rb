module Adminit
  class RolePolicy < ApplicationPolicy
    def remove_user?
      return false unless get_access(__method__)
      !(@record.id == 1 && !user.roles.include?(@record))
    end
  end
end
