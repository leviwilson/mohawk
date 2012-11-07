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

      def get_combo_box_options(locator)
        window.select_list(locator).options.map &:text
      end

      def set_combo_box_value(value, locator)
        window.select_list(locator).select value if value.instance_of? Fixnum
        window.select_list(locator).set value if value.instance_of? String
      end

      def is_checked(locator)
        window.checkbox(locator).set?
      end
      
      def check(should_check, locator)
        window.checkbox(locator).set if should_check
        window.checkbox(locator).clear unless should_check
      end

      def get_check_value(locator)
        window.checkbox(locator).value
      end

      def set_radio(locator)
        window.radio(locator).set
      end

      def radio_is_set?(locator)
        window.radio(locator).set?
      end
    end
  end
end
