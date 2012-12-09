module Mohawk
  module Accessors
    class TreeView
      def initialize(adapter, locator)
        @tree = adapter.window.select_list(locator)
      end

      def value
        @tree.value
      end

      def items
        @tree.options.map &:text
      end

      def expand(which_item)
        @tree.expand which_item
      end

      def collapse(which_item)
        @tree.collapse which_item
      end

      def select(which_item)
        @tree.select which_item if which_item.is_a? Integer
        @tree.set which_item if which_item.is_a? String
      end
    end
  end
end
