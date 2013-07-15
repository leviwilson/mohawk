module Mohawk
  module Accessors
    class Control
      attr_reader :view
      def initialize(adapter, locator)
        @adapter = adapter
        @view = adapter.window.value_control(locator)
      end

      def value
        @view.value
      end

      def set(value)
        @view.set value
      end

      def click(&block)
        @view.click &block if block
        @view.click { true } unless block
      end
    end
  end
end
