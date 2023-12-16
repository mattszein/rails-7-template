class Core::CardComponent < ViewComponent::Base
  attr_accessor :padding

  def initialize(padding = "p-12")
    @padding = padding
  end

  def html_classes
    [
      padding
    ].join(" ")
  end
end
