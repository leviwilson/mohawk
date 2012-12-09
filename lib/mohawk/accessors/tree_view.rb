module Mohawk
  module Accessors
    class TreeView
      def initialize(adapter, locator)
        @tree = adapter.window.select_list(locator)
      end

      def value
        @tree.value
      end

      def select(which_item)
        @tree.select which_item if which_item.is_a? Integer
        @tree.set which_item if which_item.is_a? String
      end
    end
  end
end
