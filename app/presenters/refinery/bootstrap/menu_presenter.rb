require 'action_view/helpers/output_safety_helper'

module Refinery
  module Bootstrap
    class MenuPresenter < ::Refinery::Pages::MenuPresenter
      include ActionView::Helpers::OutputSafetyHelper
      
      # needed for refinerycms 2.1 stable. Only on master.
      config_accessor :list_tag_css
      
      def render_menu_items(menu_items, menu_items_css)
        if menu_items.present?
          content_tag(list_tag, :class => menu_items_css) do
            menu_items.each_with_index.inject(ActiveSupport::SafeBuffer.new) do |buffer, (item, index)|
              buffer << render_menu_item(item, index)
            end
          end
        end
      end
      
      def render_menu_item(menu_item, index)
        content_tag(list_item_tag, :class => menu_item_css(menu_item, index)) do
          buffer = ActiveSupport::SafeBuffer.new
          if menu_item_children(menu_item).present?
            buffer << link_to(raw("#{menu_item.title} <span class=\"caret\"></span>"), context.refinery.url_for(menu_item.url), :class => 'dropdown-toggle', 'data-toggle' => 'dropdown')
            buffer << render_menu_items(menu_item_children(menu_item), 'dropdown-menu')
          else
            buffer << link_to(menu_item.title, context.refinery.url_for(menu_item.url))
          end
          buffer
        end
      end
      
    end
  end
end
