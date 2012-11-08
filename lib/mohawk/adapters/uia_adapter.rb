module Mohawk
  module Adapters
    class UiaAdapter
      attr_reader :window

      def initialize(locator)
        @window = RAutomation::Window.new(locator.merge(:adapter => :ms_uia))
      end

      def combo(locator)
        Mohawk::Accessors::Combo.new(self, locator)
      end

      def checkbox(locator)
        Mohawk::Accessors::CheckBox.new(self, locator)
      end

      def text(locator)
        Mohawk::Accessors::Text.new(self, locator)
      end

      def button(locator)
        Mohawk::Accessors::Button.new(self, locator)
      end

      def radio(locator)
        Mohawk::Accessors::Radio.new(self, locator)
      end
	  
      def label(locator)
        Mohawk::Accessors::Label.new(self, locator)
      end
    end
  end
end
