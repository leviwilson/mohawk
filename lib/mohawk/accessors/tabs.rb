module Mohawk
  module Accessors
    class Tabs
      attr_reader :view

      def initialize(adapter, locator)
        @view = adapter.window.tab_control(locator)
      end

      def value
        view.value
      end

      def items
        @view.items.map(&:text)
      end
    end
  end
end
