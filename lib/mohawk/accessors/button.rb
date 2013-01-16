module Mohawk
  module Accessors
    class Button
      attr_reader :control

      def initialize(adapter, locator)
        @control = adapter.window.button(locator)
      end

      def click(&block)
        @control.click &block if block
        @control.click {true} unless block
      end

      def value
        @control.value
      end
    end
  end
end
