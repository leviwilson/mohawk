module Mohawk
  module Accessors
    class Table
      attr_reader :view

      include Enumerable

      def initialize(adapter, locator)
        @view = adapter.window.table(locator)
      end

      def select(which_item)
        find_row_with(which_item).select
      end

      def add(which_item)
        find_row_with(which_item).add_to_selection
      end

      def clear_all
        view.selected_rows.each(&:clear)
      end

      def clear(which_item)
        find_row_with(which_item).clear
      end

      def find_row_with(row_info)
        found_row = case row_info
                      when Hash
                        find_by_hash(row_info)
                      when Fixnum
                        find_by_index(row_info)
                      when String
                        find_by_value(row_info)
                    end
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
      def find_by_index(which_item)
        self[which_item]
      end

      def find_by_value(which_item)
        find { |r| r.row.value == which_item }
      end

      def find_by_hash(row_info)
        find { |r| r.all_match? row_info }
      end
    end
  end
end
