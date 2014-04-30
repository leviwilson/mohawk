module Mohawk
  module Adapters
    module UIA
      class Spinner < Control
        valid_control_types :spinner

        def value=(value)
          spinner.value = value
        end

        def value
          spinner.value
        end

        def increment
          self.value = value + spinner.small_change
        end

        def decrement
          self.value = value - spinner.small_change
        end

        private
        def spinner
          element.as :range_value
        end
      end
    end
  end
end