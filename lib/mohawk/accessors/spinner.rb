module Mohawk
  module Accessors
    class Spinner
      attr_reader :view

      def initialize(adapter, locator)
        @view = adapter.window.spinner(locator)
      end

      def value
        @view.value
      end

      def value=(value)
        @view.set value
      end

      def increment
        @view.increment
      end

      def decrement
        @view.decrement
      end
    end
  end
end
