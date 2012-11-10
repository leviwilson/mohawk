require "rautomation"
require "mohawk/version"
require "mohawk/accessors"
require "mohawk/accessors/button"
require "mohawk/accessors/checkbox"
require "mohawk/accessors/combo"
require "mohawk/accessors/label"
require "mohawk/accessors/radio"
require "mohawk/accessors/text"
require "mohawk/navigation"
require "mohawk/adapters/uia_adapter"

module Mohawk

  attr_reader :adapter

  def self.included(cls)
    cls.extend Mohawk::Accessors
  end

  def initialize
    @adapter = Mohawk::Adapters::UiaAdapter.new(which_window)
  end 

  #
  # Returns whether or not the window exists
  #
  def exist?
    adapter.window.exist?
  end

end
