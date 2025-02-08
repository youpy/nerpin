# frozen_string_literal: true

require File.expand_path('lib/nerpin/version', __dir__)

Gem::Specification.new do |gem|
  gem.required_ruby_version = '~> 2.0'

  gem.authors       = ['youpy']
  gem.email         = ['9128+youpy@users.noreply.github.com']
  gem.description   = 'A Ruby library to send manufacturer-specific or instrument-specific MIDI messages'
  gem.summary       = 'A Ruby library to send manufacturer-specific or instrument-specific MIDI messages'
  gem.homepage      = ''

  gem.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.name          = 'nerpin'
  gem.require_paths = ['lib']
  gem.version       = Nerpin::VERSION

  gem.add_dependency('json')
  gem.add_dependency('nokogiri')
  gem.metadata['rubygems_mfa_required'] = 'true'
end
