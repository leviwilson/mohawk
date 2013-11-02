module Mohawk
  module Adapters
    module UIA
      class SelectList < Control

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
          items.map &:name
        end

        private
        def select_list
          element.as :selection
        end

        def find(value)
          case value
            when String
              items.find { |e| e.name == value }
            when Fixnum
              items[value]
          end
        end

        def items
          select_list.selection_items
        end

        def selected_items
          items.select &:selected?
        end
      end
    end
  end
end