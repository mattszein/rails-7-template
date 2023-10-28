# frozen_string_literal: true

class Core::Form::ButtonComponentPreview < ViewComponent::Preview
  def default
    primary
  end

  def primary
    render(Core::Form::ButtonComponent.new(type: :primary, size: :md).with_content("Primary"))
  end

  def secondary
    render(Core::Form::ButtonComponent.new(type: :secondary, size: :md).with_content("Secondary"))
  end

  def create
    render(Core::Form::ButtonComponent.new(type: :secondary, size: :md).with_content("Secondary"))
  end
end
