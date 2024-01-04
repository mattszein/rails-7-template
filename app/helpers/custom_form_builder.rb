# app/helpers/custom_form_builder.rb
class CustomFormBuilder < ViewComponent::Form::Builder
  # Set the namespace you want to use for your own components
  namespace "Core"

  def labeled(method, text = nil, options = {}, &block)
    render_component("form::Labeled", @object_name, method, text, objectify_options(options), &block)
  end

  def text_field(method, options = {})
    render_component("form::TextField", @object_name, method, objectify_options(options))
  end

  def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
    render_component("form::CheckBox", @object_name, method, checked_value, unchecked_value, objectify_options(options))
  end

  def toggle(method, options = {}, checked_value = "1", unchecked_value = "0")
    render_component("form::Toggle", @object_name, method, checked_value, unchecked_value, objectify_options(options))
  end

  def button(value = "", style = {theme: :primary, size: :md, fullw: false}, options = {}, &block)
    render_component("form::Button", value, style, options, &block)
  end

  def code(method, length = 6, options = {})
    render_component("form::Code", @object_name, method, length)
  end
end
