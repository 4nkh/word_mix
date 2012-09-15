# -*- encoding: utf-8 -*-
require File.expand_path('../lib/word_mix/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["sparkplug"]
  gem.email         = ["mathieub@4nkh.com"]
  gem.description   = %q{conflicting objectives}
  gem.summary       = %q{word mixing test}
  gem.homepage      = "https://github.com/4nkh/word_mix"

  gem.add_development_dependency "rspec"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "word_mix"
  gem.require_paths = ["lib"]
  gem.version       = WordMix::VERSION
end
