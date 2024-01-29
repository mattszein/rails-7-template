module Adminit
  class DashboardPolicy < ApplicationPolicy
    alias_rule :index?, :create?, :new?, to: :manage?
  end
end
