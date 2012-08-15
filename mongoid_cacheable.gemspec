# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mongoid_cacheable/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Noah H. Smith"]
  gem.email         = ["nsmith@rendergardenmedia.com"]
  gem.description   = %q{Cache Methods in any Mongoid Document}
  gem.summary       = %q{Adds the ability to cache any instance method into a
                         Mongoid Document}
  gem.homepage      = "http://github.com/noazark/mongoid_cacheable"

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mongoid_cacheable"
  gem.require_paths = ["lib"]
  gem.version       = MongoidCacheable::VERSION
  
  gem.add_dependency("mongoid", ["~> 3.0.0"])
  gem.add_dependency("activesupport", ["~> 3.2.0"])

  gem.add_development_dependency("rake")
  gem.add_development_dependency("rspec")
end
