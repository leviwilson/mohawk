require "fado/version"
require "fado/accessors"
require "fado/navigation"

module Fado
  def exist?
    the_window.exist?
  end

  def self.included(cls)
    cls.extend Fado::Accessors
  end

end
