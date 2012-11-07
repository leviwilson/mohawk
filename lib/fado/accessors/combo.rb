module Fado
  module Accessors
    class Combo
      def initialize(adapter, locator)
        @combo = adapter.window.select_list(locator)
      end

      def value
        @combo.value
      end

      def set(value)
        @combo.select value if value.instance_of? Fixnum
        @combo.set value if value.instance_of? String
      end

      def options
        @combo.options.map &:text
      end
    end
  end
end
