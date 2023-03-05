# -*- encoding: utf-8 -*-

Gem::Specification.new do |spec|
  spec.name          = "prairielearn-formatters"
  spec.version       = '0.1.0'
  spec.authors       = ["Armando Fox"]
  spec.email         = ["fox@berkeley.edu"]

  spec.summary       = %q{RSpec/Cucumber formatters that output JSON compatible with PrairieLearn external grader specification}
  spec.homepage      = 'https://github.com/saasbook/prairielearn-formatters'
  spec.licenses      = 'BSD-1-Clause'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
end
