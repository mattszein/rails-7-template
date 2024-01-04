class Core::SidebarComponentPreview < ViewComponent::Preview
  # @label Playground
  # @param open toggle
  def playground(open: true)
    render Core::SidebarComponent.new(open: true)
  end
end
