module Mohawk
  module Adapters
    module RAuto
      class Label
        attr_reader :view

        def initialize(adapter, locator)
          @view = adapter.window.label(locator)
        end

        def value
          @view.value
        end
      end
    end
  end
end
