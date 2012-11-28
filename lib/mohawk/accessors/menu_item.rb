module Mohawk
  module Accessors
    class MenuItem
      def initialize(adapter, locator)
        @adapter = adapter
        @locator = locator
      end

      def select
        menu_item.open
      end

      private
      def menu_item
        @locator[:path].reduce(@adapter.window) do |the_menu, menu_item|
          the_menu.menu :text => menu_item
        end
      end
    end
  end
end
