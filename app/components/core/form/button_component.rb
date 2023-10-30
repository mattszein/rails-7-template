# frozen_string_literal: true

class Core::Form::ButtonComponent < ViewComponent::Base
  attr_accessor :theme, :size

  THEME_MAPPINGS = {
    primary: "button-primary",
    secondary: "button-secondary",
    create: "button-create"
  }.freeze

  SIZE_MAPPINGS = {
    sm: "button-sm",
    md: "button-md",
    lg: "button-lg",
    xlg: "button-xlg",
    giant: "button-giant"
  }.freeze

  def initialize(theme: :primary, size: :md)
    @theme = theme
    @size = size
  end

  def classes
    (THEME_MAPPINGS[@theme] + " " + SIZE_MAPPINGS[@size])
  end
end
