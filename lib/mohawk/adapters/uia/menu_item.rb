module Mohawk
  module Adapters
    module UIA
      class MenuItem < Control
        class MenuItemNotFound < StandardError; end

        def select
          menu_item.as(:invoke).invoke
        end

        def click
          menu_item.click_center
        end

        def exist?
          !!menu_item
        rescue MenuItemNotFound
          false
        end

        private
        def menu_item
          current_item = @parent
          path.each_with_index do |menu_item, index|
            current_item = current_item.filter(control_type: :menu_item, name: menu_item).first
            raise MenuItemNotFound, menu_item unless current_item
            try_to_expand current_item unless index == path.count - 1
          end
          current_item
        end

        def path
          @locator[:path]
        end

        def try_to_expand(item)
          case
            when item.patterns.include?(:expand_collapse)
              item.as(:expand_collapse).expand
            else
              item.as(:invoke).invoke
          end
        end
      end
    end
  end
end