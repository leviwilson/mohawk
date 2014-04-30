module Mohawk
  module Adapters
    module UIA
      class Button < Control
        include Mohawk::Waiter
        valid_control_types :button

        def click
          element.as(:invoke).invoke
        end
      end
    end
  end
end