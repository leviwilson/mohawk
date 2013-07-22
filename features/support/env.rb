$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../', 'lib'))

require 'rspec-expectations'
require 'childprocess'
require 'mohawk'

World(Mohawk::Navigation)

require_rel 'screens'

Mohawk.app_path = 'features/support/WindowsForms.exe'

Mohawk::Navigation.routes = {
  :default => [
    [MainScreen, :about],
    [AboutScreen, :close],
    [MainScreen, :data_entry_form_button],
    [DataEntryForm]
  ]  
}

Before do
  @process = Mohawk.start
  RAutomation::WaitHelper.wait_until {RAutomation::Window.new(:pid => @process.pid).present?}
end

After do
  @process.stop
end
