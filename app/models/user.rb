class User < ApplicationRecord
  validates :email,
    presence: true,
    uniqueness: {case_sensitive: false},
    format: {with: URI::MailTo::EMAIL_REGEXP}

  belongs_to :role, optional: true

  passwordless_with :email

  def adminit_access?
    role.present?
  end
end
