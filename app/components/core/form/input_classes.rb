module Core::Form::InputClasses
  attr_accessor :theme, :size
  THEMES = {
    primary: "focus:border-primary-600 dark:focus:border-primary-500",
    secondary: "focus:border-secondary-600 dark:focus:border-secondary-500"
  }.freeze

  SIZES = {
    sm: "px-2 pb-1 pt-3 text-sm",
    md: "pb-2 pt-3 group-[.is-floating]:pb-2 group-[.is-floating]:pt-7 text-base"
  }.freeze

  DEFAULT = {theme: :primary, size: :md}.freeze

  def initialize(form, object_name, method_name, options = nil)
    custom_style = options&.delete(:custom_style) || {}
    options_merged = DEFAULT.merge(custom_style)
    @theme = options_merged[:theme]
    @size = options_merged[:size]
    super(form, object_name, method_name, options)
  end

  def html_class
    class_names("block rounded-t-lg w-full text-gray-900 dark:bg-gray-700 border-0 border-b-2 border-gray-300 appearance-none dark:text-white dark:border-gray-600 focus:outline-none focus: focus:ring-0 peer bg-transparent px-0 group-[.is-filled]:bg-gray-50 group-[.is-filled]:px-3.5", THEMES[theme], SIZES[size])
  end
end
