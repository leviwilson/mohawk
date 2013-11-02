module Mohawk
  module Adapters
    module UIA
      class TabControl < Control
        def selected_tab=(which)
          find(which).select
        end

        def value
          tab_items.find(&:selected?).name
        end

        def items
          tab_items.map &:name
        end

        private
        def find(which)
          case which
            when Regexp
              tab_items.find {|e| e.name =~ which }
            when String
              tab_items.find {|e| e.name == which }
            when Fixnum
              tab_items[which]
          end
        end

        def tab_items
          element.select(control_type: :tab_item).map {|e| e.as :selection_item }
        end
      end
    end
  end
end