module Adminit
  class RolePolicy < ApplicationPolicy
    def remove_user?
      return false unless manage?
      !(@record.id == 1 && !user.roles.include?(@record))
    end
  end
end
