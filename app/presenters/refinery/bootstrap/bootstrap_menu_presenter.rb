module Refinery
  module Bootstrap
    class BootstrapMenuPresenter < ::Refinery::Pages::MenuPresenter
    include ActionView::Helpers::OutputSafetyHelper

    config_accessor :collapse_at
    self.collapse_at = -1

    self.menu_tag = :nav
    self.dom_id = nil
    self.css = 'navbar navbar-inverse'
    self.selected_css = :active

    private
      def render_menu(items)
        content_tag(menu_tag, :id => dom_id, :class => css) do
          render_menu_items(items, 'nav nav-pills nav-justified', false)
        end
      end

      def render_menu_items(menu_items, menu_css, menu_inline)
        if menu_items.present?
          if menu_inline then
              menu_items.each_with_index.inject(ActiveSupport::SafeBuffer.new) do |buffer, (item, index)|
                buffer << render_menu_item(item, index)
                # buffer << render_toggle_button if (index == collapse_at)
              end
          else
            content_tag(list_tag, :class => menu_css) do
              menu_items.each_with_index.inject(ActiveSupport::SafeBuffer.new) do |buffer, (item, index)|
                if menu_item_children(item).present? and item.depth != 0 and index > 0
                  buffer << content_tag(:li, index, :class => "divider")
                end
                buffer << render_menu_item(item, index)
                # buffer << render_toggle_button if (index == collapse_at)
              end
            end
          end
        end
      end

      def render_menu_item(menu_item, index)
        content_tag(list_item_tag, :class => menu_item_css(menu_item, index)) do
          buffer = ActiveSupport::SafeBuffer.new
          if menu_item_children(menu_item).present?
            if menu_item.depth == 0
              buffer << link_to(raw("#{menu_item.title} <b class=\"caret\"></b>"), context.refinery.url_for(menu_item.url), :class => 'dropdown-toggle', 'data-toggle' => 'dropdown')
              buffer << render_menu_items(menu_item_children(menu_item), 'dropdown-menu', false)
            else
              buffer << raw("#{menu_item.title}")
              buffer << render_menu_items(menu_item_children(menu_item), nil, true)
            end
          else
            buffer << link_to(menu_item.title, context.refinery.url_for(menu_item.url))
          end
          buffer
        end
      end

      def menu_item_css(menu_item, index)
        css = []

        css << selected_css if selected_item_or_descendant_item_selected?(menu_item)
        css << :dropdown if menu_item_children(menu_item).present? and menu_item.depth == 0
        css << "dropdown-header" if menu_item_children(menu_item).present? and menu_item.depth > 0

        css.reject(&:blank?).presence
      end

    end
  end
end
