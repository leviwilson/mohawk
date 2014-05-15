$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rspec'
require 'rspec/mocks'
require 'rspec-given'
require 'mohawk'
require 'coveralls'

require 'require_all'
require_rel 'screens'

Coveralls.wear!

include Mohawk::Navigation

def start_app
  Mohawk.app_path = 'features/support/WindowsForms.exe'
  Mohawk.start
  on(MainForm)
end

RSpec.configure do |config|
  config.after(:each) do
    Mohawk.stop if Mohawk.app
    Mohawk.timeout = 60
  end
end
