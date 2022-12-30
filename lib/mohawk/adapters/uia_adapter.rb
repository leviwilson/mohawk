require 'mohawk/waiter'
require_rel 'uia'

module Mohawk
  module Adapters
    class UiaAdapter
      include UIA

      attr_reader :locator

      def initialize(locator, container=nil)
        @children_only = locator.delete :children_only
        @locator = locator
        @container = container
      end

      def window
        @window ||= Window.new @locator, @container
      end

      def value_control(locator)
        ValueControl.new self, merge(locator)
      end

      def button(locator)
        Button.new self, merge(locator)
      end

      def table(locator)
        Table.new self, merge(locator)
      end

      def checkbox(locator)
        CheckBox.new self, merge(locator)
      end

      def combo(locator)
        ComboboxControl.new self, merge(locator)
      end

      def select_list(locator)
        SelectList.new self, merge(locator)
      end

      def tree_view(locator)
        TreeView.new self, merge(locator)
      end

      def radio(locator)
        Radio.new self, merge(locator)
      end

      def text(locator)
        TextBox.new self, merge(locator)
      end

      def tab_control(locator)
        TabControl.new self, merge(locator)
      end

      def menu_item(locator)
        MenuItem.new self, merge(locator)
      end

      def spinner(locator)
        Spinner.new self, merge(locator)
      end

      def control(locator)
        Control.new self, merge(locator)
      end

      alias_method :label, :control
      alias_method :link, :control

      private
      def merge(locator)
        locator = locator.merge children_only: true if @children_only
        locator
      end
    end
  end
end
