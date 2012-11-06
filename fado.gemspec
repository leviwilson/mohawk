# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fado/version'

Gem::Specification.new do |gem|
  gem.name          = "fado"
  gem.version       = Fado::VERSION
  gem.authors       = ["Levi Wilson"]
  gem.email         = ["levi@leviwilson.com"]
  gem.description   = %q{High level wrapper around windows applications}
  gem.summary       = %q{High level wrapper around windows applications}
  gem.homepage      = "http://github.com/leviwilson/fado"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'rautomation'

  gem.add_development_dependency 'childprocess'
  gem.add_development_dependency 'rspec'
end
