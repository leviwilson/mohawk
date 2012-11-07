module Fado
  module Accessors
    class CheckBox
      def initialize(adapter, locator)
        @checkbox = adapter.window.checkbox(locator)
      end

      def checked?
        @checkbox.set?
      end

      def set_check(should_check)
        @checkbox.set if should_check
        @checkbox.clear unless should_check
      end

      def value
        @checkbox.value
      end
    end
  end
end
