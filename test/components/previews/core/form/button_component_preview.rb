# frozen_string_literal: true

class Core::Form::ButtonComponentPreview < ViewComponent::Preview
  # @label Playground
  # @param text
  # @param theme select [primary, secondary, create]
  # @param size select [sm, md, lg, xlg, giant]
  def playground(text: "Button", theme: :primary, size: :md)
    render(Core::Form::ButtonComponent.new(theme: theme, size: size)) do
      text
    end
  end

  # @!group Themes

  # @label Primary (default)
  def primary
    render(Core::Form::ButtonComponent.new(theme: :primary)) do
      "Primary"
    end
  end

  # @label Secondary
  def secondary
    render(Core::Form::ButtonComponent.new(theme: :secondary )) do
      "Secondary"
    end
  end

  # @label Create
  def create
    render(Core::Form::ButtonComponent.new(theme: :create)) do
      "Create"
    end
  end
  # @!endgroup

  # @!group Sizes

  # @label Small
  def small
    render(Core::Form::ButtonComponent.new(size: :sm)) do
      "Button"
    end
  end

  # @label Medium (default)
  def medium
    render(Core::Form::ButtonComponent.new(size: :md)) do
      "Button"
    end
  end

  # @label Large
  def large
    render(Core::Form::ButtonComponent.new(size: :lg)) do
      "Button" 
    end
  end

  # @label X-Large
  def xlarge
    render(Core::Form::ButtonComponent.new(size: :xlg)) do
      "Button"
    end
  end

  # @label Giant
  def giant
    render(Core::Form::ButtonComponent.new(size: :giant)) do
      "Button" 
    end
  end

  # @!endgroup
end
