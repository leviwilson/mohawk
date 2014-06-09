module Mohawk
  module Adapters
    module UIA
      class MenuItem < Control
        class MenuItemNotFound < StandardError;
        end

        def select
          until_successful { element.select_menu_item(*path) }
        end

        def click
          until_successful { element.menu_item(*path).click_center }
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

        def until_successful(&block)
          wait_until do
            begin
              block.call
              true
            rescue
              false
            end
          end
        end
      end
    end
  end
end