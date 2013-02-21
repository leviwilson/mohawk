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

      def select
        @table.view.select row.row
      end

      def cells
        row.cells.map &:text
      end

      def value_from_header(name)
        which_column = header_methods.index(name)
        raise ArgumentError, "#{name} column does not exist in #{header_methods}" if which_column.nil?
        cells[which_column]
      end
      
      def method_missing(name, *args)
        value_from_header name
      end

      def to_hash
        {:text => row.text, :row => row.row }
      end

      private
      def header_methods
        @headers ||= @table.headers.map(&:to_method)
      end
    end
  end
end
