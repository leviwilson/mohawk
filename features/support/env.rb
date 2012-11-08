$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../', 'lib'))

require 'rspec-expectations'
require 'childprocess'
require 'mohawk'

World(Mohawk::Navigation)

Before do
  @process = ChildProcess.build('features\\support\\WindowsForms.exe')
  @process.start
  RAutomation::WaitHelper.wait_until {RAutomation::Window.new(:pid => @process.pid).present?}
end

After do
  @process.stop
end
