module ApplicationHelper
  TICKET_STATUS_THEME = {open: :green, closed: :red, in_progress: :yellow}

  def ticket_status_theme(status)
    TICKET_STATUS_THEME[status.to_sym]
  end
end
