module Mohawk
  module Adapters
    module UIA
      class Table < Control
        include ElementLocator

        def select(which)
          find_row_with(which).select
        end

        def headers
          table.headers.map &:name
        end

        def find_row_with(which)
          case which
            when Hash
              find_by_hash(which)
            else
              find(which)
          end
        end

        private
        def table
          element.as :table
        end

        def find_by_hash(which)
        end

        def all_items
          table.rows.map do |row|
            row.as(:selection_item)
          end
        end
      end
    end
  end
end