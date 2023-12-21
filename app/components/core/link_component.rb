class Core::LinkComponent < ViewComponent::Base
  include ActionView::Helpers::UrlHelper
  attr_accessor :style, :theme, :size, :name, :url, :options

  STYLE = {default: :default,
           as_button: :as_button,
           no_style: :no_style}.freeze
  DEFAULT = {style: :as_button, theme: :primary, size: :md}.freeze

  def initialize(name: nil, url: nil, options: {}, &block)
    custom_style = options&.delete(:custom_style) || {}
    style_merged = DEFAULT.merge(custom_style)

    @style = style_merged[:style]
    @theme = style_merged[:theme]
    @size = style_merged[:size]
    @name = name
    @url = url
    @options = options
  end

  def html_class
    case style
    when :as_button
      Core::Form::ButtonComponent.new(nil, nil, {theme: theme, size: size}).html_class
    when :default
      "inline-flex items-center justify-center border border-transparent rounded-md font-semibold focus:outline-none focus:ring-2 focus:ring-offset-2"
    end
  end

  def render_content
    if content
      link_to(url, options) do
        content
      end
    else
      link_to(name, url, class: html_class)
    end
  end

  erb_template <<~ERB
    <%= render_content %>
  ERB
end
