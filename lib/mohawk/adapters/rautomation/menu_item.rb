module Mohawk
  module Adapters
    module RAuto
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
          path.reduce(@adapter.window) do |the_menu, menu_item|
            the_menu.menu :text => menu_item
          end
        end

        def path
          [@locator[:path] || @locator[:text]].flatten
        end
      end
    end
  end
end
