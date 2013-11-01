require_rel 'rautomation'

module Mohawk
  module Adapters
    class RAutomationAdapter
      include RAuto

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
        @combos[locator] ||= Combo.new(self, merge(locator))
      end


      def checkbox(locator)
        @checkbox ||= {}
        @checkbox[locator] ||= CheckBox.new(self, merge(locator))
      end

      def text(locator)
        @text_fields ||= {}
        @text_fields[locator] ||= Text.new(self, merge(locator))
      end

      def button(locator)
        @buttons ||= {}
        @buttons[locator] ||= Button.new(self, merge(locator))
      end

      def radio(locator)
        @radios ||= {}
        @radios[locator] ||= Radio.new(self, merge(locator))
      end
	  
      def label(locator)
        @labels ||= {}
        @labels[locator] ||= Label.new(self, merge(locator))
      end

      def link(locator)
        @links ||= {}
        @links[locator] ||= Link.new(self, merge(locator))
      end

      def menu_item(locator)
        MenuItem.new(self, merge(locator))
      end

      def table(locator)
        @tables ||= {}
        @tables[locator] ||= Table.new(self, merge(locator))
      end

      def tree_view(locator)
        @trees ||= {}
        @trees[locator] ||= TreeView.new(self, merge(locator))
      end

      def value_control(locator)
        @controls ||= {}
        @controls[locator] ||= Control.new(self, merge(locator))
      end

      def spinner(locator)
        Spinner.new(self, merge(locator))
      end

      def tab_control(locator)
        Tabs.new(self, merge(locator))
      end

      private
      def merge(locator)
        locator = locator.merge(:children_only => true) if @only_search_children
        locator
      end
    end
  end
end
