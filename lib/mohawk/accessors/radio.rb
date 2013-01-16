module Mohawk
  module Accessors
    class Radio
      attr_reader :control

      def initialize(adapter, locator)
        @control = adapter.window.radio(locator)
      end

      def set
        @control.set
      end

      def set?
        @control.set?
      end
    end
  end
end
