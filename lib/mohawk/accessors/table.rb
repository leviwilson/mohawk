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
            select_by_hash(which_item)
          else
            select_by_value(which_item)
        end
      end

      def find_row_with(row_info)
        found_row = find { |r| r.all_match? row_info }
        raise "A row with #{row_info} was not found" unless found_row
        found_row
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
        case which_item
          when Fixnum
            row = self[which_item]
          else
            row = view.row(text: which_item)
        end
        row.select
      end

      def select_by_hash(which_item)
        found_row = find_row_with(which_item)
        found_row.select
        found_row
      end
    end
  end
end
