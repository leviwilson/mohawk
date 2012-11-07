module Fado
  module Accessors
    class Button
      def initialize(adapter, locator)
        @button = adapter.window.button(locator)
      end

      def click(&block)
        @button.click &block if block
        @button.click {true} unless block
      end

      def value
        @button.value
      end
    end
  end
end
