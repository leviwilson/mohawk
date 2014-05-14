module Mohawk
  module Adapters
    module UIA
      class MenuItem < Control
        class MenuItemNotFound < StandardError; end

        def select
          element.select_menu_item(*path)
        end

        def click
          element.menu_item(*path).click_center
        end

        def exist?
          !!element.menu_item(*path)
        end
        alias_method :exists?, :exist?

        private
        def element
          @parent.with(:menu_items)
        end

        def path
          [@locator[:path] || @locator[:text]].flatten
        end
      end
    end
  end
end