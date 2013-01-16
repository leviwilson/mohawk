module Mohawk
  module Accessors
    class Combo
      attr_reader :control

      def initialize(adapter, locator)
        @control = adapter.window.select_list(locator)
      end

      def value
        @control.value
      end

      def set(value)
        @control.select value if value.instance_of? Fixnum
        @control.set value if value.instance_of? String
      end

      def options
        @control.options.map &:text
      end
    end
  end
end
