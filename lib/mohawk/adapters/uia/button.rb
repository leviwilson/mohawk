module Mohawk
  module Adapters
    module UIA
      class Button < Control
        include Mohawk::Waiter, Locators

        def value
          element.name
        end

        def click
          element.as(:invoke).invoke
        end
      end
    end
  end
end