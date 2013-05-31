module Mohawk
  module Adapters
    class UiaAdapter
      def initialize(locator, container=nil)
        @only_search_children = locator.delete(:children_only)
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
        @combos ||= {}
        @combos[locator] ||= Mohawk::Accessors::Combo.new(self, merge(locator))
      end


      def checkbox(locator)
        @checkbox ||= {}
        @checkbox[locator] ||= Mohawk::Accessors::CheckBox.new(self, merge(locator))
      end

      def text(locator)
        @text_fields ||= {}
        @text_fields[locator] ||= Mohawk::Accessors::Text.new(self, merge(locator))
      end

      def button(locator)
        @buttons ||= {}
        @buttons[locator] ||= Mohawk::Accessors::Button.new(self, merge(locator))
      end

      def radio(locator)
        @radios ||= {}
        @radios[locator] ||= Mohawk::Accessors::Radio.new(self, merge(locator))
      end
	  
      def label(locator)
        @labels ||= {}
        @labels[locator] ||= Mohawk::Accessors::Label.new(self, merge(locator))
      end

      def link(locator)
        @links ||= {}
        @links[locator] ||= Mohawk::Accessors::Link.new(self, merge(locator))
      end

      def menu_item(locator)
        Mohawk::Accessors::MenuItem.new(self, merge(locator))
      end

      def table(locator)
        @tables ||= {}
        @tables[locator] ||= Mohawk::Accessors::Table.new(self, merge(locator))
      end

      def tree_view(locator)
        @trees ||= {}
        @trees[locator] ||= Mohawk::Accessors::TreeView.new(self, merge(locator))
      end

      def value_control(locator)
        @controls ||= {}
        @controls[locator] ||= Mohawk::Accessors::Control.new(self, merge(locator))
      end

      private
      def merge(locator)
        locator = locator.merge(:children_only => true) if @only_search_children
        locator
      end
    end
  end
end
