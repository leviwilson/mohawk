module Mohawk
  module Accessors
    class MenuItem
      def initialize(adapter, locator)
        @adapter = adapter
        @locator = locator
      end

      def select
        menu_items = Array.new @locator[:path]
        menu = @adapter.window.menu(:text => menu_items.shift)
        menu_items.each do |menu_item|
          menu.menu :text => menu_item
        end
        menu.open
      end
    end
  end
end
