module Mohawk
  module Adapters
    module UIA
      module Locators
        private
        def sanitize(locator)
          locator.reduce({}) do |h, p|
            k, v = p
            k = :name if [:title, :value].include? k
            h[k] = v
            h
          end
        end
      end
    end
  end
end