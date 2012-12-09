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
        @tree.select which_item
      end
    end
  end
end
