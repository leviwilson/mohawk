require "rautomation"
require "fado/version"
require "fado/accessors"
require "fado/accessors/combo"
require "fado/accessors/checkbox"
require "fado/accessors/text"
require "fado/navigation"
require "fado/adapters/uia_adapter"

module Fado

  attr_reader :adapter

  def self.included(cls)
    cls.extend Fado::Accessors
  end

  def initialize
    @adapter = Fado::Adapters::UiaAdapter.new(which_window)
  end 

  def exist?
    adapter.window.exist?
  end

end
