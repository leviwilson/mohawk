module Mohawk
  module Adapters
    module UIA
      class Control
        include Mohawk::Waiter, Locators

        def initialize(adapter, locator)
          @parent = adapter.window.element
          @locator = sanitize(locator)
        end

        def element
          @element ||= wait_for do
            @parent.find @locator
          end
        end
      end
    end
  end
end