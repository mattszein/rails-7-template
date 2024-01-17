class Role < ApplicationRecord
  has_and_belongs_to_many :users, through: :roles_users

  def self.declare_methods
    all.each do |role|
      Role.send(:define_singleton_method, "is_#{role.name}?") do |id|
        role.id == id
      end
    end
  end

  declare_methods

  def self.access_adminit?(roles)
    roles.length > 0
  end
end
