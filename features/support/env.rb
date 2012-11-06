$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../', 'lib'))

require 'rspec-expectations'
require 'childprocess'
require 'fado'

World(Fado::Navigation)

Before do
  @process = ChildProcess.build('features\\support\\WindowsForms.exe')
  @process.start
end

After do
  @process.stop
end
