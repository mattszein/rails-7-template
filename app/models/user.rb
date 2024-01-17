class User < ApplicationRecord
  validates :email,
    presence: true,
    uniqueness: {case_sensitive: false},
    format: {with: URI::MailTo::EMAIL_REGEXP}

  has_and_belongs_to_many :roles, through: :roles_users

  passwordless_with :email
end
