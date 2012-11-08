module Mohawk
  module Accessors
    class Radio
      def initialize(adapter, locator)
        @radio = adapter.window.radio(locator)
      end

      def set
        @radio.set
      end

      def set?
        @radio.set?
      end
    end
  end
end
