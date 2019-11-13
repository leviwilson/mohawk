require_rel 'control'

module Mohawk
  module Adapters
    module UIA
      class Button < Control
        include Mohawk::Waiter
        valid_patterns :invoke

        def click
          element.as(:invoke).invoke
        end
      end
    end
  end
end