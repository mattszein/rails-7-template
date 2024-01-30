class Permission < ApplicationRecord
  validates :resource, presence: true, uniqueness: true
  validates :role_ids, presence: true, array: {presence: true, exclusion: {in: ["", nil]}}

  default_scope { order(resource: :asc) }
  def self.default
    find_by(resource: "ApplicationPolicy")
  end
end
