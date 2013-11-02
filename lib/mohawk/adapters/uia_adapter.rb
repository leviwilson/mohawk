require 'mohawk/waiter'
require_rel 'uia'

module Mohawk
  module Adapters
    class UiaAdapter
      include UIA

      def initialize(locator)
        @locator = locator
      end

      def window
        @window ||= Window.new @locator
      end

      def value_control(locator)
        ValueControl.new self, locator
      end

      def button(locator)
        Button.new self, locator
      end

      def checkbox(locator)
        CheckBox.new self, locator
      end

      def combo(locator)
        SelectList.new self, locator
      end

      def text(locator)
        TextBox.new self, locator
      end

      def control(locator)
        Control.new self, locator
      end
      alias_method :label, :control
      alias_method :link, :control
    end
  end
end