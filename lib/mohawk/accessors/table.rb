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
          @table.view.selected? row.row
        end

        def cells
          row.cells.map &:text
        end
        
        def method_missing(name, *args)
          cells[@table.headers.map(&:to_method).index(name)]
        end

        def to_hash
          {:text => row.text, :row => row.row }
        end
      end

      attr_reader :view

      def initialize(adapter, locator)
        @view = adapter.window.table(locator)
      end

      def select(which_item)
        view.select which_item
      end

      def headers
        RAutomation::Adapter::MsUia::UiaDll.table_headers(view.hwnd)
      end

      def rows
        view.rows.map do |row|
          Row.new(self, row).to_hash
        end
      end

      def row(which_row)
        Row.new self, view.row(:index => which_row)
      end
    end
  end
end
