# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mohawk/version'

Gem::Specification.new do |gem|
  gem.name          = "mohawk"
  gem.version       = Mohawk::VERSION
  gem.authors       = ["Levi Wilson"]
  gem.email         = ["levi@leviwilson.com"]
  gem.description   = %q{High level wrapper around windows applications}
  gem.summary       = %q{High level wrapper around windows applications}
  gem.homepage      = "http://github.com/leviwilson/mohawk"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'rautomation', '~> 0.9.3'
  gem.add_dependency 'require_all'
  gem.add_dependency 'page_navigation', '>= 0.7'

  gem.add_development_dependency 'cucumber'
  gem.add_development_dependency 'rspec', '>= 2.12.0'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'childprocess'
  gem.add_development_dependency 'rb-fsevent', '~> 0.9.1'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'terminal-notifier-guard'
  gem.add_development_dependency 'json', '~> 1.7.7'
end
