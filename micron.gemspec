# -*- encoding: utf-8 -*-
require File.expand_path('../lib/micron/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["youpy"]
  gem.email         = ["youpy@buycheapviagraonlinenow.com"]
  gem.description   = %q{A Ruby library to controll Alesis micron using MIDI}
  gem.summary       = %q{A Ruby library to controll Alesis micron using MIDI}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "micron"
  gem.require_paths = ["lib"]
  gem.version       = Micron::VERSION

  gem.add_development_dependency('rspec', ['~> 2.12'])
  gem.add_development_dependency('rake')
  gem.add_development_dependency('webmock')
  gem.add_development_dependency('micron')

  gem.add_dependency('nokogiri')
  gem.add_dependency('json')
end
