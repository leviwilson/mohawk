module Mohawk
  module Adapters
    module RAuto
      class Button
        attr_reader :view

        def initialize(adapter, locator)
          @view = adapter.window.button(locator)
        end

        def click(&block)
          @view.click &block if block
          @view.click { true } unless block
        end

        def value
          @view.value
        end
      end
    end
  end
end
