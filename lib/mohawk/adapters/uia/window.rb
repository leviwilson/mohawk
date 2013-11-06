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
          element.send_keys keys
        end

        def active?
          Mohawk::Win32.foreground_window == element.handle
        end

        def exist?
          Mohawk::Win32.is_window element.handle
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
          wait_for { element }
        end
      end
    end
  end
end