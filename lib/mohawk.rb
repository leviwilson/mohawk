require "rautomation"
require "mohawk/version"
require "require_all"
require "mohawk/accessors"
require "mohawk/navigation"
require "mohawk/adapters/uia_adapter"
require "mohawk/core_ext/string"

require_rel "mohawk/accessors"

module Mohawk
  class InvalidApplicationPath < StandardError
    def initialize(message='You must set the Mohawk.app_path to start an application')
      super
    end
  end

  attr_reader :adapter

  def self.included(cls)
    cls.extend Mohawk::Accessors
  end

  def self.start
    raise InvalidApplicationPath.new
  end

  def initialize(extra={})
    locator = [which_window.merge(extra)]
    locator << parent_container if respond_to?(:parent_container)
    @adapter = Mohawk::Adapters::UiaAdapter.new(*locator)
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
  # Waits until a control exists
  #
  def wait_for_control(locator)
    control = adapter.window.control(locator)
    begin
      RAutomation::WaitHelper.wait_until { control.exist? }
    rescue
      raise "A control with #{locator} was not found"
    end
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
