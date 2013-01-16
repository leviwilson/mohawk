module Mohawk
  module Accessors
    class Text
      attr_reader :control 

      def initialize(adapter, locator)
        @adapter = adapter
        @control = adapter.window.text_field(locator)
      end

      def value
        @control.value
      end

      def set(text)
        @control.set text
      end

      def clear
        @control.clear
      end

      def enter(text)
        text_window = @adapter.window.child(:hwnd => @control.hwnd)
        text_window.send_keys text.split(//)
      end
    end
  end
end
