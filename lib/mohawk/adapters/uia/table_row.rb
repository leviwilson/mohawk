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

        def method_missing(name, *args)
          value_from_header name
        end

        private
        def selection_item
          @element.as :selection_item
        end

        def value_from_header(name)
          which_column = header_methods.index(name)
          raise ArgumentError, "#{name} column does not exist in #{header_methods}" if which_column.nil?
          cells[which_column]
        end

        def header_methods
          @headers ||= @table.headers.map(&:to_method)
        end
      end
    end
  end
end
