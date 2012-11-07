module Fado
  module Adapters
    class UiaAdapter
      attr_reader :window

      def initialize(locator)
        @window = RAutomation::Window.new(locator.merge(:adapter => :ms_uia))
      end

      def combo(locator)
        Fado::Accessors::Combo.new(self, locator)
      end

      def checkbox(locator)
        Fado::Accessors::CheckBox.new(self, locator)
      end

      def text(locator)
        Fado::Accessors::Text.new(self, locator)
      end

      def button(locator)
        Fado::Accessors::Button.new(self, locator)
      end

      def radio(locator)
        Fado::Accessors::Radio.new(self, locator)
      end
    end
  end
end
