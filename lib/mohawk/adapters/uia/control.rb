module Mohawk
  module Adapters
    module UIA
      class Control
        include Mohawk::Waiter

        def initialize(adapter, locator)
          @parent = adapter.window.element
          @locator = locator
        end

        def click
          element.click
        end

        def focus
          element.focus
        end

        def exist?
          locate_element != nil
        end

        def enabled?
          exist? && element.enabled?
        end

        def disabled?
          !enabled?
        end

        def visible?
          exist? && element.visible?
        end

        def element
          @element ||= wait_for  { locate_element }
        end

        def handle
          element.handle
        end

        def value
          element.name
        end
        alias_method :control_name, :value

        def view
          self
        end

        def method_missing(meth, *args, &block)
          if element.respond_to? meth
            element.send meth, *args, &block
          else
            super
          end
        end

        private
        def locate_element
          scope = (@locator.delete(:children_only) && :children) || :descendants
          @parent.find @locator.merge(scope: scope)
        end
      end
    end
  end
end