require "rautomation"
require 'childprocess'
require "mohawk/version"
require "require_all"
require "mohawk/accessors"
require "mohawk/navigation"
require "mohawk/adapters/rautomation_adapter"
require "mohawk/adapters/uia_adapter"
require "mohawk/core_ext/string"

require_rel "mohawk/accessors"

module Mohawk
  include Waiter
  extend Waiter

  class InvalidApplicationPath < StandardError
    def initialize(message='You must set the Mohawk.app_path to start an application')
      super
    end
  end

  def self.included(cls)
    cls.extend Mohawk::Accessors
  end

  attr_reader :adapter

  def self.start
    raise InvalidApplicationPath.new unless @app_path
    @app = ChildProcess.build(@app_path).start

    app_window = RAutomation::Window.new :pid => @app.pid
    wait_until { app_window.present? }
  end

  def self.stop
    raise 'An application was never started' unless @app
    @app.stop unless @app.exited?
    @app = nil
  end

  def self.app
    @app
  end

  def self.app_path=(path)
    @app_path = path
  end

  def self.default_adapter
    @default_adapter || Mohawk::Adapters::RAutomationAdapter
  end

  def self.default_adapter=(cls)
    @default_adapter = cls
  end

  def initialize(extra={})
    locator = [which_window.merge(extra)]
    locator << parent_container if respond_to?(:parent_container)
    @adapter = Mohawk.default_adapter.new(*locator)
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
    control = adapter.control(locator)
    begin
      wait_until { control.exist? }
    rescue
      raise "A control with #{locator} was not found"
    end
  end

  #
  # Indicates if the window has text or not
  #
  def has_text?(text_to_find)
    adapter.window.text.include? text_to_find
  end
end
