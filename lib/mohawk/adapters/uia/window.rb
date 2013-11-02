require 'uia'
require 'mohawk/win_32'

module Mohawk
  module Adapters
    module UIA
      class Window
        include Mohawk::Waiter, Locators
        attr_reader :element

        def initialize(locator)
          @locator = sanitize(locator)
        end

        def element
          @element ||= Uia.find_element(@locator)
        end

        def active?
          Mohawk::Win32.foreground_window == element.handle
        end

        def present?
          element != nil
        end

        def wait_until_present
          wait_for { element }
        end
      end
    end
  end
end