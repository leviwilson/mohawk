module Mohawk
  module Adapters
    module UIA
      class TextBox < Control
        valid_patterns :text, :value

        def enter(*args)
          send_keys *args
        end

        def set(value)
          if is_value?
            value_pattern.value = value
          else
            text_pattern.text = value
          end
        end

        def value
          return value_pattern.value if is_value?
          text_pattern.text
        end

        def clear
          set ''
        end

        private
        def is_value?
          element.patterns.include? :value
        end

        def value_pattern
          element.as :value
        end

        def is_text?
          element.patterns.include? :text
        end

        def text_pattern
          element.as :text
        end
      end
    end
  end
end