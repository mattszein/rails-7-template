# frozen_string_literal: true

class Core::Form::ButtonComponent < ViewComponent::Form::ButtonComponent
  attr_accessor :theme, :size

  THEME_MAPPINGS = {
    primary: "border-primary-700 hover:bg-primary-800 focus:ring-primary-300 dark:border-primary-500 dark:hover:bg-primary-500 dark:focus:ring-primary-800 text-primary-700 dark:text-primary-500",
    secondary: "border-secondary-600 hover:bg-secondary-600 focus:ring-secondary-300 dark:border-secondary-500 dark:hover:bg-secondary-500 dark:focus:ring-secondary-800 text-secondary-700 dark:text-secondary-500",
    create: "border-create-600 hover:border-create-500 hover:bg-create-500 focus:ring-create-300 dark:border-create-500 dark:hoer:bg-create-500 dark:focus:r-create-800 text-create-600 dark:text-create-500"
  }.freeze

  SIZE_MAPPINGS = {
    sm: "px-3 py-2 text-sm",
    md: "px-4 py-2.5 text-base",
    lg: "px-5 py-3 text-lg",
    xlg: "px-6 py-3.5 text-2xl",
    giant: "px-8 py-5 text-4xl"
  }.freeze

  def initialize(form, value, theme = :primary, size = :md, options = {})
    @value = value
    @theme = theme
    @size = size
    super(form, value, options)
  end

  def html_class
    class_names("border focus:ring-4 focus:outline-none rounded-lg mr-2 mb-2 font-medium text-center font-semibold hover:text-white dark:hover:text-white", THEME_MAPPINGS[@theme], SIZE_MAPPINGS[@size])
  end
end
