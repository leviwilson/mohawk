require_relative 'value_control'
require_relative 'element_locator'

module Mohawk
  module Adapters
    module UIA
      class ComboBoxControl < ValueControl
        include ElementLocator

        alias_method :ctrl_element, :element

        def value
          if supports_selection?
            selection_pattern.selected_items.map(&:name).first || ''
          else
            value_pattern.value
          end
        end

        def options
          if supports_selection?
            all_items.map &:name
          else
            element.items.map &:name
          end
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

        private
        def element
          ctrl_element.with(:combo_box)
        end
      end
    end
  end
end