module Mohawk
  module Adapters
    class UiaAdapter
      def initialize(locator, container=nil)
        @window = RAutomation::Window.new(locator.merge(:adapter => :ms_uia))
        @container = container
      end

      def window
        @actual_window ||= begin
          if @container
            control = @window.control(@container)
            RAutomation::WaitHelper.wait_until { control.exist? }
            @window = RAutomation::Window.new(:hwnd => control.hwnd, :adapter => :ms_uia)
          end
          @window
        end
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

      def link(locator)
        Mohawk::Accessors::Link.new(self, locator)
      end

      def menu_item(locator)
        Mohawk::Accessors::MenuItem.new(self, locator)
      end

      def table(locator)
        Mohawk::Accessors::Table.new(self, locator)
      end

      def tree_view(locator)
        Mohawk::Accessors::TreeView.new(self, locator)
      end

      def value_control(locator)
        Mohawk::Accessors::Control.new(self, locator)
      end
    end
  end
end
