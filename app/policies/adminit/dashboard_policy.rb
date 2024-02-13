module Adminit
  class DashboardPolicy < ApplicationPolicy
    self.identifier = :"Adminit::DashboardPolicy"
    alias_rule :index?, :create?, :new?, to: :manage?
  end
end
