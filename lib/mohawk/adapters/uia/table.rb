module Mohawk
  module Adapters
    module UIA
      class Table < Control
        include ElementLocator, Enumerable
        valid_patterns :table

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
          element.headers.map &:name
        end

        def [](index)
          row_at(index)
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

        def element
          super.as(:table)
        end

        private
        def find_by_hash(hash)
          find { |r| r.all_match? hash }
        end

        def row_at(index)
          TableRow.new self, index
        end

        def all_items
          element.row_count.times.map { |index| TableRow.new self, index }
        end
      end
    end
  end
end