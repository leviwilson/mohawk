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

      def selected_tab=(which)
        case which
          when String
            view.set(which)
          when Regexp
            view.set items.find {|t| t.match which }
          else
            view.select(which)
        end
      end

      def items
        @view.items.map(&:text)
      end
    end
  end
end
