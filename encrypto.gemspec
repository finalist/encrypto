# -*- encoding: utf-8 -*-
require File.expand_path('../lib/encrypto/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'encrypto'
  gem.version       = Encrypto::VERSION
  gem.date          = '2013-12-04'
  gem.summary       = "A gem that supports encrypting personal data by using rbnacl and attr_encrypted"
  gem.description   = "A gem that supports encrypting personal data by using rbnacl and attr_encrypted"
  gem.authors       = ["Ruben", "Arne"]
  gem.email         = 'service@finalist.nl'
  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.homepage      = 'http://github.com/finalist/encrypto'

  gem.add_dependency             "rbnacl",         "~> 2.0.0"
  gem.add_dependency             "attr_encrypted", "~> 1.3.0"

  gem.add_development_dependency "pry-nav",        "~> 0.2.3"
  gem.add_development_dependency "rspec",          "~> 2.14.1"
  gem.add_development_dependency "spec_coverage",  "~> 0.0.5"
end
