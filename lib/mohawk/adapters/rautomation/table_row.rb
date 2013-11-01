module Mohawk
  module Adapters
    module RAuto
      class TableRow
        include RAutomation::Adapter::MsUia

        attr_reader :row

        def initialize(table, row_index)
          @table = table
          @row = Row.new(@table.view, :index => row_index)
        end

        def selected?
          row.selected?
        end

        def select
          UiaDll::table_single_select(@table.view.search_information, row.row)
          self
        end

        def add_to_selection
          row.select
          self
        end

        def clear
          row.clear
          self
        end

        def cells
          row.cells.map &:text
        end

        def all_match?(hash)
          hash.all? do |key, value|
            send(key) == "#{value}"
          end
        end

        def value_from_header(name)
          which_column = header_methods.index(name)
          raise ArgumentError, "#{name} column does not exist in #{header_methods}" if which_column.nil?
          Cell.new(row, :index => which_column).text
        end

        def method_missing(name, *args)
          value_from_header name
        end

        def to_hash
          {:text => row.text, :row => row.row}
        end

        private
        def header_methods
          @headers ||= @table.headers.map(&:to_method)
        end
      end
    end
  end
end
