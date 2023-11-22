class Core::Form::TextFieldComponentPreview < ViewComponent::Preview
  require "view_component/form/test_helpers"

  # Form components are used the same way than basic rails forms.
  #
  # ```erb
  # <%= form_with model: @user do |f| %>
  #   <%= f.text_area :name %>
  # <% end %>
  # ```
  #
  # See [https://api.rubyonrails.org/classes/ActionView/Helpers/FormBuilder.html#method-i-text_area](https://api.rubyonrails.org/classes/ActionView/Helpers/FormBuilder.html#method-i-text_area).
  def basic(method: :comment)
    render Core::Form::TextFieldComponent.new(form_builder, "holi", method)
  end

  protected

  def form_builder(object_name = nil, object = nil, options = {})
    CustomFormBuilder.new(object_name, object, template, options)
  end

  def template
    lookup_context = ActionView::LookupContext.new(ActionController::Base.view_paths)

    ActionView::Base.new(lookup_context, {}, ActionController::Base.new)
  end
end
