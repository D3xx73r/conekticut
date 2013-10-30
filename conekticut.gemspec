# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'conekticut/version'

Gem::Specification.new do |spec|
  spec.name          = "conekticut"
  spec.version       = Conekticut::VERSION
  spec.authors       = ["Ian Rodriguez", "Carlos Ortega"]
  spec.email         = ["ian.rgz@gmail.com", "roh.race@gmail.com"]
  spec.description   = %q{Ruby wrapper for the Conekta API}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = "https://github.com/ianrgz/conekticut"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  s.add_dependency('rest-client', '~> 1.6.0')
  s.add_dependency('multi_json', '~> 1.8.0')

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency("rspec", "~> 2.14.1")
  s.add_development_dependency('shoulda', '~> 3.5.0')
end
