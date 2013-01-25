module Mohawk
  module Accessors
    class Table
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
          TableRow.new(self, row).to_hash
        end
      end

      def row(which_row)
        TableRow.new self, view.row(:index => which_row)
      end
    end
  end
end
