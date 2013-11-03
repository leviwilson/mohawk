module Mohawk
  module Adapters
    module UIA
      class Table < Control
        include ElementLocator, Enumerable

        def select(which)
          find_row_with(which).select
        end

        def add(which)
          find_row_with(which).add
        end

        def clear(which)
          find_row_with(which).clear
        end

        def headers
          table.headers.map &:name
        end

        def [](index)
          all_items[index]
        end

        def each
          all_items.each { |row| yield row }
        end

        def find_row_with(row_info)
          found_row = case row_info
                        when Hash
                          find_by_hash(row_info)
                        else
                          find_element(row_info)
                      end
          raise "A row with #{row_info} was not found" unless found_row
          found_row
        end

        private
        def table
          element.as :table
        end

        def find_by_hash(hash)
          find { |r| r.all_match? hash }
        end

        def all_items
          table.rows.each_with_index.map { |el, index| TableRow.new self, el, index }
        end
      end
    end
  end
end