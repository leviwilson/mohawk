module Mohawk
  module Accessors
    class Link < Label
      def click
        @label.click
      end
    end
  end
end
