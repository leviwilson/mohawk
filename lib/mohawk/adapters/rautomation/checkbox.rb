module Mohawk
  module Adapters
    module RAuto
      class CheckBox
        attr_reader :view

        def initialize(adapter, locator)
          @view = adapter.window.checkbox(locator)
        end

        def checked?
          @view.set?
        end

        def set_check(should_check)
          @view.set if should_check
          @view.clear unless should_check
        end

        def value
          @view.value
        end
      end
    end
  end
end
