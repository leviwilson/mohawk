module Mohawk
  module Adapters
    module UIA
      class MenuItem < Control
        class MenuItemNotFound < StandardError; end

        def select
          menu_item.as(:invoke).invoke
        end

        def exist?
          !!menu_item
        rescue MenuItemNotFound
          false
        end

        private
        def menu_item
          @locator[:path].reduce(@parent) do |current_item, menu_item|
            item = current_item.filter(control_type: :menu_item, name: menu_item).first
            raise MenuItemNotFound, menu_item unless item
            try_to_expand item
          end
        end

        def try_to_expand(item)
          item.as(:expand_collapse).expand
          item
        rescue
          item
        end
      end
    end
  end
end