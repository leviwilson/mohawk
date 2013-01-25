module Mohawk
  module Accessors
    class TableRow
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
  end
end
