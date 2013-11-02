module Mohawk
  module Adapters
    module UIA
      class TabControl < Control
        include ElementLocator

        def selected_tab=(which)
          find(which).select
        end

        def value
          all_items.find(&:selected?).name
        end

        def items
          all_items.map &:name
        end

        private
        def all_items
          element.select(control_type: :tab_item).map {|e| e.as :selection_item }
        end
      end
    end
  end
end