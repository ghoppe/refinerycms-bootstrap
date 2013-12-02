module Refinery
  module Bootstrap
    class NavPresenter < ::Refinery::Bootstrap::MenuPresenter

    config_accessor :nav_style
    self.nav_style = :pills
    # self.justified = false

    self.css = 'nav'
    self.css += ' nav-pills'    if nav_style.in?([:pills,:stacked])
    self.css += ' nav-pills'    if nav_style.in?([:tabs])
    self.css += ' nav-stacked'  if nav_style.in?([:stacked])
    
    self.selected_css = :active

    private
      def render_menu(items)
        render_menu_items(items, css)
      end
    
      def render_menu_items(menu_items, menu_css)
        if menu_items.present?
          content_tag(list_tag, :class => menu_css) do
            menu_items.each_with_index.inject(ActiveSupport::SafeBuffer.new) do |buffer, (item, index)|
              buffer << render_menu_item(item, index)
              # buffer << render_toggle_button if (index == collapse_at)
            end
          end
        end
      end
    
      def render_menu_item(menu_item, index)
        content_tag(list_item_tag, :class => menu_item_css(menu_item, index)) do
          buffer = ActiveSupport::SafeBuffer.new
          if menu_item_children(menu_item).present?
            buffer << link_to("#{menu_item.title} <b class=\"caret\"></b>", context.refinery.url_for(menu_item.url), :class => 'dropdown-toggle', 'data-toggle' => 'dropdown')
            buffer << render_menu_items(menu_item_children(menu_item), 'dropdown-menu')
        else
            buffer << link_to(menu_item.title, context.refinery.url_for(menu_item.url))
        end
          buffer
        end
      end
    
      def menu_item_css(menu_item, index)
        css = []

        css << selected_css if selected_item_or_descendant_item_selected?(menu_item)
        css << :dropdown if menu_item_children(menu_item).present?
      
        css.reject(&:blank?).presence
      end

    end
  end
end
