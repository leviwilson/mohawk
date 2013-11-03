module Mohawk
  module Adapters
    module UIA
      module ElementLocator
        private
        def find_element(value)
          case value
            when Regexp
              all_items.find { |e| e.name =~ value }
            when String
              all_items.find { |e| e.name == value }
            when Fixnum
              all_items[value]
          end
        end
      end
    end
  end
end