module Refinery
  module Bootstrap
	class BootstrapMenuPresenter < ::Refinery::Pages::MenuPresenter
	
	config_accessor :collapse_at
	self.collapse_at = -1
	
    self.menu_tag = :div
	self.dom_id = nil
    self.css = 'navbar'
	self.selected_css = :active
	
	private
      def render_menu(items)
        content_tag(menu_tag, :id => dom_id, :class => css) do
          content_tag(:div, render_menu_items(items, 'nav'), :class => 'navbar-inner')
        end
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