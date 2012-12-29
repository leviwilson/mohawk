module Mohawk
  module Accessors
    class Label
      def initialize(adapter, locator)
        @label = adapter.window.label(locator)
      end

      def value
        @label.value
      end
    end
  end
end