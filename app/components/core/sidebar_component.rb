class Core::SidebarComponent < ViewComponent::Base
  attr_reader :open
  def initialize(open: false)
    @open = open
  end
end
