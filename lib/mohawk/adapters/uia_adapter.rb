require 'mohawk/waiter'
require_rel 'uia'

module Mohawk
  module Adapters
    class UiaAdapter
      include UIA

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

      def checkbox(locator)
        CheckBox.new self, merge(locator)
      end

      def combo(locator)
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