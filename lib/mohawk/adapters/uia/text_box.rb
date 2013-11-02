module Mohawk
  module Adapters
    module UIA
      class TextBox < ValueControl
        def clear
          value_pattern.value = ''
        end
      end
    end
  end
end