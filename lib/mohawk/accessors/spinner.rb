module Mohawk
  module Accessors
    class Spinner
      def initialize(adapter, locator)
        @view = adapter.window.spinner(locator)
      end

      def value
        @view.value
      end

      def value=(value)
        @view.set value
      end
    end
  end
end
