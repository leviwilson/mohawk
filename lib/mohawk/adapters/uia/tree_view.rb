module Mohawk
  module Adapters
    module UIA
      class TreeView < SelectList
        def expand(what)
          find(what).as(:expand_collapse).expand
        end

        def collapse(what)
          find(what).as(:expand_collapse).collapse
        end

        def value
          selected_items.map(&:name).first
        end

        alias_method :items, :options
        alias_method :select, :set
      end
    end
  end
end