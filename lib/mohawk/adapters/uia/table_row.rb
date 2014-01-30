module Mohawk
  module Adapters
    module UIA
      class TableRow
        attr_reader :index

        def initialize(table, element, index)
          @table, @element, @index = table, element, index
        end

        def name
          @element.name
        end

        def cells
          @element.items.map &:name
        end

        def select
          selection_item.select
          self
        end

        def add
          selection_item.add_to_selection
          self
        end

        def clear
          selection_item.remove_from_selection
          self
        end

        def selected?
          selection_item.selected?
        end

        def all_match?(hash)
          hash.all? do |key, value|
            value_from_header(key) == value
          end
        end

        def to_hash
          {text: @element.name, row: index}
        end

        def method_missing(name, *args)
          value_from_header name
        end

        def value_from_header(name)
          which_column = header_methods.find_index {|h| h.to_s == name.to_s }
          raise ArgumentError, "#{name} column does not exist in #{header_methods}" if which_column.nil?
          cells[which_column]
        end

        private
        def selection_item
          @element.as :selection_item
        end

        def header_methods
          @headers ||= @table.headers.map(&:to_method)
        end
      end
    end
  end
end
