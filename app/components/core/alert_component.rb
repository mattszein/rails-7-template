class Core::AlertComponent < ViewComponent::Base
  attr_reader :type, :title, :message
  def initialize(type: :success, title: nil, message: nil)
    @type = type
    @tite = title
    @message = message
  end

  def icon
    case type
    when "success"
      "check-circle"
    when "warning"
      "exclamation-circle"
    when "danger"
      "x-circle"
    when "info"
      "information-circle"
    else
      "information-circle"
    end
  end
end
