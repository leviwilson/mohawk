module Mohawk
  module Accessors
    class Table
      attr_reader :view

      include Enumerable

      def initialize(adapter, locator)
        @view = adapter.window.table(locator)
      end

      def select(which_item)
        case which_item
          when Hash
            find do |row|
              which_item.all? {|p| row.send(p[0]) == p[1] }
            end.select
          else
            select_by_value(which_item)
        end
      end

      def headers
        RAutomation::Adapter::MsUia::UiaDll.table_headers(view.search_information)
      end

      def [](row)
        TableRow.new(self, row)
      end

      def each
        view.row_count.times.map do |row|
          yield TableRow.new(self, row)
        end
      end

      private
      def select_by_value(which_item)
        view.select which_item
      end
    end
  end
end
