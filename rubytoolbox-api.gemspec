# frozen_string_literal: true

require_relative "lib/rubytoolbox/api/version"

# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |spec|
  spec.name          = "rubytoolbox-api"
  spec.version       = Rubytoolbox::Api::VERSION
  spec.authors       = ["Christoph Olszowka"]
  spec.email         = ["christoph at olszowka de"]

  spec.summary       = "A simple, dependency-free API client for The Ruby Toolbox"
  spec.description   = spec.summary
  spec.homepage      = "https://www.ruby-toolbox.com"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/rubytoolbox/rubytoolbox-api"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-performance"
  spec.add_development_dependency "rubocop-rspec"

  spec.add_development_dependency "guard-bundler"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-rubocop"

  spec.add_development_dependency "rspec", ">= 3.9"
  spec.add_development_dependency "simplecov", ">= 0.18.5"

  spec.add_development_dependency "vcr", ">= 5.1.0"
  spec.add_development_dependency "webmock", ">= 3.8.3"
end
# rubocop:enable Metrics/BlockLength
