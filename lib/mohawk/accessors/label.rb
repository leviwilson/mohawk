module Mohawk
  module Accessors
    class Label
      attr_reader :control

      def initialize(adapter, locator)
        @control = adapter.window.label(locator)
      end

      def value
        @control.value
      end
    end
  end
end
