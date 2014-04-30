module Mohawk
  module Adapters
    module UIA
      class Radio < Control
        valid_control_types :radio_button

        def set
          selection_item.select
        end

        def set?
          selection_item.selected?
        end

        private
        def selection_item
          element.as :selection_item
        end
      end
    end
  end
end