class Core::LinkComponent < ViewComponent::Base
  include ActionView::Helpers::UrlHelper
  attr_accessor :as_button, :theme, :size, :name, :url, :options

  DEFAULT = {as_button: true, theme: :primary, size: :md}.freeze

  def initialize(name, url, options = {})
    custom_style = options&.delete(:custom_style) || {}
    style_merged = DEFAULT.merge(custom_style)
    @as_button = style_merged[:as_button]
    @theme = style_merged[:theme]
    @size = style_merged[:size]
    @name = name
    @url = url
  end

  def html_class
    case as_button
    when true
      Core::Form::ButtonComponent.new(nil, nil, {theme: theme, size: size}).html_class
    else
      "inline-flex items-center justify-center border border-transparent rounded-md font-semibold focus:outline-none focus:ring-2 focus:ring-offset-2"
    end
  end

  erb_template <<-ERB
    <%= link_to(name, url, class: html_class) %>
  ERB
end
