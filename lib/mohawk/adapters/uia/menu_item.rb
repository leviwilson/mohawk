module Mohawk
  module Adapters
    module UIA
      class MenuItem < Control
        class MenuItemNotFound < StandardError;
        end

        def select
          wait_until do
            begin
              element.select_menu_item(*path)
              true
            rescue
              false
            end
          end
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