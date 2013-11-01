module Mohawk
  module Adapters
    module RAuto
      class Text
        attr_reader :view

        def initialize(adapter, locator)
          @adapter = adapter
          @view = adapter.window.text_field(locator)
        end

        def value
          @view.value
        end

        def set(text)
          @view.set text
        end

        def clear
          @view.clear
        end

        def enter(text)
          text_window = @adapter.window.child(:hwnd => @view.hwnd)
          text_window.send_keys text.split(//)
        end
      end
    end
  end
end
