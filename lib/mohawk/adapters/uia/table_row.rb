module Mohawk
  module Adapters
    module UIA
      class TableRow
        attr_reader :index

        def initialize(table, element, index)
          @table, @element, @index = table, element, index
        end

        def cells
          @element.items.map &:name
        end

        def select
          selection_item.select
        end

        def selected?
          selection_item.selected?
        end

        def to_hash
          {text: @element.name, row: index}
        end

        private
        def selection_item
          @element.as :selection_item
        end
      end
    end
  end
end
