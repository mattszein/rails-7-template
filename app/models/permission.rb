class Permission < ApplicationRecord
  validates :resource, presence: true, uniqueness: true
  validates :role_ids, presence: true, array: {presence: true, exclusion: {in: ["", nil]}}
  validate :roles_existence

  default_scope { order(resource: :asc) }
  def self.default
    find_by(resource: Adminit::ApplicationPolicy.identifier)
  end

  def roles_existence
    return true if role_ids.blank?
    errors.add(:role_ids, "There is an Invalid id") unless Role.where(id: role_ids).count == role_ids.count
  end
end
