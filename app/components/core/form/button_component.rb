# frozen_string_literal: true

class Core::Form::ButtonComponent < ViewComponent::Base
  attr_accessor :type

  PRIMARY_CLASSES = %w[
    border-primary-700 hover:bg-primary-800 focus:ring-primary-300 dark:border-primary-500 dark:hover:bg-primary-500 dark:focus:ring-primary-800 text-primary-700 dark:text-primary-500
  ].freeze
  SECONDARY_CLASSES = %w[
    border-secondary-600 hover:bg-secondary-600 focus:ring-secondary-300 dark:border-secondary-500 dark:hover:bg-secondary-500 dark:focus:ring-secondary-800 text-secondary-700 dark:text-secondary-500
  ].freeze
  CREATE_CLASSES = %w[border-create-600 hover:border-create-500 hover:bg-create-500 focus:ring-create-300 dark:border-create-500 dark:hover:bg-create-500 dark:focus:ring-create-800 text-create-600 dark:text-create-500].freeze
  BASE_CLASSES = %w[
    border focus:ring-4 focus:outline-none rounded-lg mr-2 mb-2 font-medium text-center font-semibold hover:text-white dark:hover:text-white
  ].freeze
  SIZE_SMALL_CLASSES = %w[px-3 py-2 text-sm].freeze
  SIZE_MEDIUM_CLASSES = %w[px-4 py-2.5 text-base].freeze
  SIZE_LARGE_CLASSES = %w[px-5 py-2.5 text-lg].freeze

  BUTTON_TYPE_MAPPINGS = {
    primary: PRIMARY_CLASSES,
    secondary: SECONDARY_CLASSES,
    create: CREATE_CLASSES
  }.freeze

  BUTTON_SIZE_MAPPINGS = {
    sm: SIZE_SMALL_CLASSES,
    md: SIZE_MEDIUM_CLASSES,
    lg: SIZE_LARGE_CLASSES
  }.freeze

  def initialize(type: :primary, size: :md)
    @type = type
    @size = size
  end

  def classes
    (BUTTON_TYPE_MAPPINGS[@type] + BUTTON_SIZE_MAPPINGS[@size] + BASE_CLASSES).join(" ")
  end
end
