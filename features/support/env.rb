$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../', 'lib'))

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
  Mohawk.start
end

After do
  Mohawk.stop
end
