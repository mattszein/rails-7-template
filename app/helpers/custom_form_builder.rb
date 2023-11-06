# app/helpers/custom_form_builder.rb
class CustomFormBuilder < ViewComponent::Form::Builder
  # Set the namespace you want to use for your own components
  namespace "Core::Form"

  def labeled(method, text = nil, options = {}, &block)
    render_component(:labeled, @object_name, method, text, objectify_options(options), &block)
  end
end
