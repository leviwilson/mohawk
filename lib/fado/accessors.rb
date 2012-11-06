module Fado
  module Accessors
    def window(locator)
      define_method("which_window") do
        locator
      end
    end
  end
end
