module Mohawk
  module Accessors
    class Table
      def initialize(adapter, locator)
        @table = adapter.window.table(locator)
      end

      def select(which_item)
        @table.select which_item if which_item.is_a? Integer
        @table.set which_item if which_item.is_a? String
      end

      def rows
        @table.rows.map do |row|
          {:text => row.text, :row => row.row }
        end
      end
    end
  end
end
