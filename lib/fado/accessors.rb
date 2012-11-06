require 'rautomation'

module Fado
  module Accessors
    def window(locator)
      define_method("the_window") do
        @window ||= RAutomation::Window.new(locator)
      end
    end
  end
end
