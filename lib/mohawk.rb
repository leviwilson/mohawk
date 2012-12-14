require "rautomation"
require "mohawk/version"
require "mohawk/accessors"
require "mohawk/accessors/button"
require "mohawk/accessors/checkbox"
require "mohawk/accessors/combo"
require "mohawk/accessors/label"
require "mohawk/accessors/menu_item"
require "mohawk/accessors/radio"
require "mohawk/accessors/table"
require "mohawk/accessors/text"
require "mohawk/accessors/tree_view"
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

  #
  # Returns whether or not the window is active
  #
  def active?
    adapter.window.active?
  end

  #
  # Returns whether or not the window is present
  #
  def present?
    adapter.window.present?
  end

  #
  # Waits until the window is present
  #
  def wait_until_present
    adapter.window.wait_until_present
  end

  #
  # Waits until the block returns true
  #
  def wait_until(timeout=RAutomation::Window.wait_timeout, &block)
    RAutomation::WaitHelper.wait_until timeout, &block
  end

  #
  # Indicates if the window has text or not
  #
  def has_text?(text_to_find)
    adapter.window.text.include? text_to_find
  end
end
