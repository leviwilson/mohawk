require_relative 'value_control'
require_relative 'element_locator'

module Mohawk
  module Adapters
    module UIA
      class ComboboxControl < ValueControl
        include ElementLocator

        def set(value)
          if supports_selection?
            click_or_select find_element(value)
          else
            value_pattern.value = value
          end
        end

        def value
          if supports_selection?
            selection_pattern.selected_items.map(&:name).first || ''
          else
            value_pattern.value
          end
        end

        def options
          all_items.map &:name
        end

        private

        def all_items
          selection_pattern.selection_items
        end

        def click_or_select(item)
          item.click
        rescue
          item.select
        end

        def selection_pattern
          element.as :selection
        end

        def supports_selection?
          selection_pattern
          true
        rescue
          false
        end
      end
    end
  end
end