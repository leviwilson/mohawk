module Mohawk
  module Adapters
    module UIA
      class ValueControl < Control
        def set(value)
          value_pattern.value = value
        end

        def value
          value_pattern.value
        end

        private
        def value_pattern
          element.as :value
        end
      end
    end
  end
end