# app/helpers/custom_form_builder.rb
class CustomFormBuilder < ViewComponent::Form::Builder
  # Set the namespace you want to use for your own components
  namespace "Core::Form"

  def labeled(method, text = nil, theme = :primary, style = :default, options = {}, &block)
    render_component(:labeled, @object_name, method, theme, style, text, objectify_options(options), &block)
  end

  def toggle(method, options = {}, checked_value = "1", unchecked_value = "0", theme = :primary, size = :sm)
    render_component(:toggle, @object_name, method, checked_value, unchecked_value, theme, size,
      objectify_options(options))
  end

  def button(value = "", theme = :primary, size = :md, options = {}, &block)
    render_component(:button, value, theme, size, options, &block)
  end
end
