class User < ApplicationRecord
  validates :email,
    presence: true,
    uniqueness: {case_sensitive: false},
    format: {with: URI::MailTo::EMAIL_REGEXP}

  belongs_to :role, optional: true
  has_many :assigned_tickets, class_name: "Ticket", foreign_key: :assigned_id
  has_many :created_tickets, class_name: "Ticket", foreign_key: :created_id

  passwordless_with :email

  def adminit_access?
    role.present?
  end
end
