module Mohawk
  module Accessors
    class Text
      def initialize(adapter, locator)
        @adapter = adapter
        @text = adapter.window.text_field(locator)
      end

      def value
        @text.value
      end

      def set(text)
        @text.set text
      end

      def clear
        @text.clear
      end

      def enter(text)
        text_window = @adapter.window.child(:hwnd => @text.hwnd)
        text_window.send_keys text.split(//)
      end
    end
  end
end
