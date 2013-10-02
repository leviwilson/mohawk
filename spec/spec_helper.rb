$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rspec'
require 'rspec/mocks'
require 'ffi_stub'
require 'mohawk'
require 'coveralls'
require_rel 'table_stubber'

Coveralls.wear!
