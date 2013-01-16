module Mohawk
  module Accessors
    class Link < Label
      def click
        @control.click
      end
    end
  end
end
