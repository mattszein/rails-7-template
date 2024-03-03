class Ticket < ApplicationRecord
  belongs_to :created, class_name: "User", optional: true
  belongs_to :assigned, class_name: "User", optional: true
  enum :status, {open: 0, in_progress: 1, closed: 2}, default: :open, validate: {allow_nil: false}
  validates_presence_of :title, :description, :priority, :status, :created_id

  broadcasts_to ->(ticket) { "tickets" }, partial: "adminit/tickets/ticket_table"
  after_update_commit ->(ticket) { broadcast_replace_later_to ActionView::RecordIdentifier.dom_id(ticket), target: ActionView::RecordIdentifier.dom_id(ticket), partial: "adminit/tickets/ticket" }

  default_scope { order(priority: :desc, created_at: :desc) }
end
