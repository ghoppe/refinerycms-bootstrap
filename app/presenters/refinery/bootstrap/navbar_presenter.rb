module Refinery
  module Bootstrap
    class NavbarPresenter < ::Refinery::Bootstrap::MenuPresenter

      config_accessor :brand, :brand_link, :container_css, :header_css,  :brand_css

      self.css = 'navbar navbar-default'
      self.menu_tag = :nav

      self.container_css = 'container-fluid'
      self.header_css = 'navbar-header'

      self.brand = nil
      self.brand_link = '/'
      self.brand_css = 'navbar-brand'

      self.selected_css = :active
      self.list_tag_css = 'nav navbar-nav'
      self.first_css = nil
      self.last_css  = nil

      private
        def render_navbar_header
          content_tag(:div, :class => header_css ) do
            buffer = ActiveSupport::SafeBuffer.new
            buffer << render_navbar_toggle
            buffer << link_to(brand, brand_link, :class => brand_css) unless brand.nil?
            buffer
          end
        end

        def render_navbar_toggle
          content_tag(:button, :class => 'navbar-toggle', :type => :button, :data => {:toggle => :collapse, :target => ".navbar-#{dom_id}-collapse"}) do
            buffer = ActiveSupport::SafeBuffer.new
            buffer << content_tag(:span,'Toggle navigation',  :class => 'sr-only')
            3.times do
              buffer << content_tag(:span, "", :class => 'icon-bar')
            end
            buffer
          end
        end

        def render_collapse_menu_items(items)
          content_tag(:div, :class => "collapse navbar-collapse navbar-#{dom_id}-collapse") do
            buffer = ActiveSupport::SafeBuffer.new
            buffer << render_menu_items(items, list_tag_css)
            buffer
          end
        end

        def render_menu(items)
          content_tag(menu_tag, :id => dom_id, :class => css) do
            content_tag(:div, :class => container_css) do
              buffer = ActiveSupport::SafeBuffer.new
              buffer << render_navbar_header
              buffer << render_collapse_menu_items(items)
              buffer
            end
          end
        end

    end
  end
end
