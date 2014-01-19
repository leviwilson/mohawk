module Mohawk
  module Adapters
    module UIA
      class SelectList < Control
        include ElementLocator

        def set(value)
          which = find_element(value)
          if select_list.multi_select?
            which.add_to_selection
          else
            click_or_select which
          end
        end

        def clear(value)
          find_element(value).remove_from_selection
        end

        def value
          values.first || ''
        end

        def values
          selected_items.map &:name
        end

        def selected_items
          select_list.selected_items
        end

        def options
          all_items.map &:name
        end

        private
        def select_list
          element.as :selection
        end

        def all_items
          select_list.selection_items
        end

        def click_or_select(item)
          item.click
        rescue
          item.select
        end
      end
    end
  end
end