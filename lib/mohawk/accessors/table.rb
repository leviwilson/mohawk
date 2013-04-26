module Mohawk
  module Accessors
    class Table
      attr_reader :view

      include Enumerable

      def initialize(adapter, locator)
        @view = adapter.window.table(locator)
      end

      def select(which_item)
        view.select which_item
      end

      def headers
        RAutomation::Adapter::MsUia::UiaDll.table_headers(view.search_information)
      end

      def [](row)
        TableRow.new(self, view.row(:index => row))
      end

      def each
        view.rows.map do |row|
          yield TableRow.new(self, row)
        end
      end
    end
  end
end
