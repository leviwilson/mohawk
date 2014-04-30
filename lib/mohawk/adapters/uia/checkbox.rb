module Mohawk
  module Adapters
    module UIA
      class CheckBox < Control
        valid_control_types :check_box

        def set_check(should_check)
          toggle.toggle_state = should_check ? :on : :off
        end

        def checked?
          toggle.toggle_state == :on
        end

        private
        def toggle
          element.as :toggle
        end
      end
    end
  end
end