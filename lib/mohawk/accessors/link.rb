module Mohawk
  module Accessors
    class Link < Label
      def click
        @view.click
      end
    end
  end
end
