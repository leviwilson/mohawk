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
          @element ||= Uia.find_element(@locator)
          if @element && @container
            @element = @element.find(@container) || @element
          end
          @element
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
          element.handle
        end

        def title
          element.name
        end

        def text
          element.descendants.map &:name
        end

        def present?
          element != nil
        end

        def wait_until_present
          wait_until { element }
        end
      end
    end
  end
end