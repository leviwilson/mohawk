module Mohawk
  module Adapters
    module UIA
      class Table < Control
        include ElementLocator, Enumerable

        def select(which)
          find_row_with(which).as(:selection_item).select
        end

        def add(which)
          find_row_with(which).as(:selection_item).add_to_selection
        end

        def clear(which)
          find_row_with(which).as(:selection_item).remove_from_selection
        end

        def headers
          table.headers.map &:name
        end

        def [](index)
          TableRow.new self, all_items[index], index
        end

        def each
          all_items.each_with_index.map { |el, index| yield TableRow.new self, el, index }
        end

        def find_row_with(row_info)
          found_row = case row_info
                        when Hash
                          find_by_hash(row_info)
                        else
                          find(row_info)
                      end
          raise "A row with #{row_info} was not found" unless found_row
          found_row
        end

        private
        def table
          element.as :table
        end

        def find_by_hash(which)
        end

        def all_items
          table.rows
        end
      end
    end
  end
end