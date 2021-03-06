require 'uia'
require 'mohawk/win_32'

module Mohawk
  module Adapters
    module UIA
      class Window
        include Mohawk::Waiter
        attr_reader :element

        def initialize(locator, container)
          @locator = locator
          @container = container
        end

        def element
          @element ||= locate_element
        end

        def send_keys(*keys)
          activate
          element.send_keys keys
        end

        def active?
          Mohawk::Win32.foreground_window == handle
        end

        def activate
          Mohawk::Win32.set_foreground_window handle
          Mohawk::Win32.activate handle
        end

        def exist?
          Mohawk::Win32.is_window handle
        end

        def handle
          (locate_element && element.handle) || 0
        end

        def title
          element.name
        end

        def text
          element.descendants.map &:name
        end

        def present?
          locate_element != nil
        end

        def wait_until_present(context=nil)
          wait_until(Mohawk.timeout, context) { element }
        end

        private
        def locate_element
          element = Uia.find_element(@locator)
          if element && @container
            element = element.find(@container) || element
          end
          element
        end
      end
    end
  end
end
