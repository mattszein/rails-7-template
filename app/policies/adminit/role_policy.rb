module Adminit
  class RolePolicy < ApplicationPolicy
    self.identifier = :"Adminit::RolePolicy"
    def remove_user?
      return false unless manage?
      !(@record.id == 1 && (user.role == @record && @record.users.length == 1))
    end
  end
end
