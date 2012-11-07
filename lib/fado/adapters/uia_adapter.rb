module Fado
  module Adapters
    class UiaAdapter
      attr_reader :window

      def initialize(locator)
        @window = RAutomation::Window.new(locator.merge(:adapter => :ms_uia))
      end

      def set_text(text, locator)
        window.text_field(locator).set text
      end

      def get_text(locator)
        window.text_field(locator).value
      end

      def clear_text(locator)
        window.text_field(locator).clear
      end

      def click_button(locator, &block)
        window.button(locator).click &block if block
        window.button(locator).click {true } unless block
      end

      def get_button_value(locator)
        window.button(locator).value
      end

      def get_combo_box_value(locator)
        window.select_list(locator).value
      end

      def set_combo_box_value(value, locator)
        window.select_list(locator).select value if value.instance_of? Fixnum
        window.select_list(locator).set value if value.instance_of? String
      end
    end
  end
end
