module Mohawk
  module Adapters
    module RAuto
      class Link < Label
        def click
          @view.click
        end
      end
    end
  end
end
