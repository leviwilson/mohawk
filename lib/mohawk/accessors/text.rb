module Mohawk
  module Accessors
    class Text
      def initialize(adapter, locator)
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
    end
  end
end
