# config/initializers/will_paginate.rb

module WillPaginate
  module ViewHelpers
    # default options that can be overridden on the global level
    @@pagination_options = {
      :class        => 'pagination',
      :prev_label   => '&laquo; Previous',
      :next_label   => 'Next &raquo;',
      :inner_window => 3, # links around the current page
      :outer_window => 0, # links around beginning and end
      :separator    => ' ', # single space is friendly to spiders and non-graphic browsers
      :param_name   => :page,
      :params       => nil,
      :renderer     => 'WillPaginate::LinkRenderer',
      :page_links   => true,
      :container    => true
    }
    mattr_reader :pagination_options
  end
  module ActionView
    def will_paginate(collection = nil, options = {})
      options[:renderer] ||= BootstrapLinkRenderer
      super.try :html_safe
    end

    class BootstrapLinkRenderer < LinkRenderer
      protected
      
      def html_container(html)
        tag :ul, html, container_attributes
      end

      def page_number(page)
        tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
      end

      def previous_or_next_page(page, text, classname)
        tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('disabled' unless page)].join(' ')
      end
      
      def gap
   		tag :li, link('&hellip;'.html_safe, '#'), :class => 'disabled success'
 	  end
    end
  end
end