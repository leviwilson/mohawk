# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mohawk/version'

Gem::Specification.new do |gem|
  gem.name          = "mohawk"
  gem.version       = Mohawk::VERSION
  gem.authors       = ["Levi Wilson"]
  gem.email         = ["levi@leviwilson.com"]
  gem.description   = %q{Mohawk is a page-object style driver that makes it easy to automate windows applications. It allows you to create a very flexible, clean and natural DSL around whatever windows application that you are trying to automate using the RAutomation gem as the underlying driver.}
  gem.summary       = %q{Provides a page-object style driver for automating Windows applications}
  gem.homepage      = "http://github.com/leviwilson/mohawk"
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'rautomation', '>= 0.14.1'
  gem.add_dependency 'uia', '>= 0.2.1'
  gem.add_dependency 'require_all'
  gem.add_dependency 'page_navigation', '>= 0.7'
  gem.add_dependency 'childprocess', '~> 0.3.9'

  gem.add_development_dependency 'cucumber'
  gem.add_development_dependency 'rspec', '>= 2.12.0'
  gem.add_development_dependency 'rspec-given'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'childprocess'
  gem.add_development_dependency 'rb-fsevent', '~> 0.9.1'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'terminal-notifier-guard'
  gem.add_development_dependency 'json', '~> 1.7.7'
end
