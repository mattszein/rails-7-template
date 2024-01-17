# Base class for application policies
class ApplicationPolicy < ActionPolicy::Base
  default_rule :manage?
  alias_rule :index?, :edit?, to: :access?

  def manage?
    get_access(__method__)
  end

  private

  # Define shared methods useful for most policies.
  # For example:
  #
  #  def owner?
  #    record.user_id == user.id
  #  end

  def get_access(method)
    setting = Adminit::AuthorizationSettings.get(self.class.identifier, method)
    user.roles.any? { |role| setting.include?(role.id) }
  end
end
