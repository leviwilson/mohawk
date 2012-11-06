require "fado/version"
require "fado/navigation"

module Fado
  def exist?
    false
  end

  def self.included(cls)
    cls.extend self
  end

  def window(locator)
    define_method("the_window") do
      @window = RAutomation::Window.new(locator)
    end
  end

end
