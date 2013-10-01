module Mohawk
  module Accessors
    class TreeView
      attr_reader :view

      def initialize(adapter, locator)
        @view = adapter.window.select_list(locator)
      end

      def value
        @view.value
      end

      def items
        @view.options.map &:text
      end

      def expand(which_item)
        @view.expand which_item
      end

      def collapse(which_item)
        @view.collapse which_item
      end

      def select(which_item)
        @view.options[which_item].select if which_item.is_a? Integer
        @view.option(text: which_item).select if which_item.is_a? String
      end
    end
  end
end
