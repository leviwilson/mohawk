require 'uia'

module Mohawk
  module Adapters
    module UIA
      class Window
        include Mohawk::Waiter, Locators
        attr_reader :element

        def initialize(locator)
          @locator = sanitize(locator)
        end

        def wait_until_present
          wait_for { @element = Uia.find_element(@locator) }
        end
      end
    end
  end
end