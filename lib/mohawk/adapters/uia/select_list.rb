module Mohawk
  module Adapters
    module UIA
      class SelectList < Control
        include ElementLocator

        def set(value)
          which = find(value)
          do_it = (select_list.multi_select? && :add_to_selection) || :select
          which.send do_it
        end

        def clear(value)
          find(value).remove_from_selection
        end

        def values
          selected_items.map &:name
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

        def selected_items
          all_items.select &:selected?
        end
      end
    end
  end
end