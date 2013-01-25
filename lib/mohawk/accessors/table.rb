module Mohawk
  module Accessors
    class Table
      class Row
        attr_reader :row

        def initialize(table, row)
          @row = row
          @table = table
        end
        
        def selected?
          @table.table.selected? row.row
        end

        def cells
          row.cells.map &:text
        end
        
        def method_missing(name, *args)
          header_methods = @table.headers.map do |header|
            header.gsub(/\W+/, "_").downcase.to_sym
          end
          
          cells[header_methods.index(name)]
        end

        def to_hash
          {:text => row.text, :row => row.row }
        end
      end

      attr_reader :table

      def initialize(adapter, locator)
        @table = adapter.window.table(locator)
      end

      def select(which_item)
        table.select which_item
      end

      def headers
        RAutomation::Adapter::MsUia::UiaDll.table_headers(table.hwnd)
      end

      def rows
        table.rows.map do |row|
          Row.new(self, row).to_hash
        end
      end

      def row(which_row)
        Row.new self, table.row(:index => which_row)
      end

      def view
        table
      end
    end
  end
end
