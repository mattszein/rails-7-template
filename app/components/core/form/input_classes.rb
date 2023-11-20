module Core::Form::InputClasses
  THEMES = {
    primary: "focus:border-primary-600 dark:focus:border-primary-500",
    secondary: "focus:border-secondary-600 dark:focus:border-secondary-500"
  }.freeze

  SIZES = {
    sm: "px-2 pb-1 pt-3 text-sm",
    md: "pb-2 pt-3 group-[.is-floating]:pb-2 group-[.is-floating]:pt-7 text-base"
  }.freeze

  STYLE = {
    default: "",
    filled: ""
  }.freeze

  def html_class
    class_names("block rounded-t-lg w-full text-gray-900 dark:bg-gray-700 border-0 border-b-2 border-gray-300 appearance-none dark:text-white dark:border-gray-600 focus:outline-none focus:ring-0 peer bg-transparent px-0 group-[.is-filled]:bg-gray-50 group-[.is-filled]:px-3.5", THEMES[:primary], SIZES[:md], STYLE[:default])
  end
end
