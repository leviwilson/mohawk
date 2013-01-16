module Mohawk
  module Accessors
    class CheckBox
      attr_reader :control

      def initialize(adapter, locator)
        @control = adapter.window.checkbox(locator)
      end

      def checked?
        @control.set?
      end

      def set_check(should_check)
        @control.set if should_check
        @control.clear unless should_check
      end

      def value
        @control.value
      end
    end
  end
end
