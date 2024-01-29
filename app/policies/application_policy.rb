# Base class for application policies
class ApplicationPolicy < ActionPolicy::Base
  default_rule :manage?
  alias_rule :index?, :create?, to: :manage?

  def manage?
    get_access(self.class.class_name)
  end

  private

  # Define shared methods useful for most policies.
  # For example:
  #
  #  def owner?
  #    record.user_id == user.id
  #  end

  def get_access(key = self.class.class_name)
    setting = Permission.find_by(resource: key)
    setting = setting&.role_ids || Permission.default&.role_ids
    setting.include?(user.role_id)
  end
end
