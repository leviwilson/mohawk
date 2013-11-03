module Mohawk
  module Adapters
    module UIA
      class TextBox < ValueControl
        alias_method :enter, :send_keys

        def clear
          value_pattern.value = ''
        end
      end
    end
  end
end