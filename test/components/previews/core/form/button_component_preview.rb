# frozen_string_literal: true

class Core::Form::ButtonComponentPreview < ViewComponent::Preview
  # @label Playground
  # @param text
  # @param theme select [primary, secondary, create]
  # @param size select [sm, md, lg, xlg, giant]
  def playground(text: "Button", theme: :primary, size: :md, options: {})
    render Core::Form::ButtonComponent.new(form_builder, text, theme, size, options)
  end

  # @!group Themes

  # @label Primary (default)
  def primary
    render Core::Form::ButtonComponent.new(form_builder, "Button", :primary, :md, {})
  end

  # @label Secondary
  def secondary
    render(Core::Form::ButtonComponent.new(form_builder, "Button", :secondary, :md, {}))
  end

  # @label Create
  def create
    render(Core::Form::ButtonComponent.new(form_builder, "Button", :create, :md, {}))
  end
  # @!endgroup

  # @!group Sizes

  # @label Small
  def small
    render(Core::Form::ButtonComponent.new(form_builder, "Button", :primary, :sm, {}))
  end

  # @label Medium (default)
  def medium
    render(Core::Form::ButtonComponent.new(form_builder, "Button", :primary, :md, {}))
  end

  # @label Large
  def large
    render(Core::Form::ButtonComponent.new(form_builder, "Button", :primary, :lg, {}))
  end

  # @label X-Large
  def xlarge
    render(Core::Form::ButtonComponent.new(form_builder, "Button", :primary, :xlg, {}))
  end

  # @label Giant
  def giant
    render(Core::Form::ButtonComponent.new(form_builder, "Button", :primary, :giant, {}))
  end

  # @!endgroup

  protected

  def form_builder(object_name = nil, object = nil, options = {})
    CustomFormBuilder.new(object_name, object, template, options)
  end

  def template
    lookup_context = ActionView::LookupContext.new(ActionController::Base.view_paths)

    ActionView::Base.new(lookup_context, {}, ActionController::Base.new)
  end
end
