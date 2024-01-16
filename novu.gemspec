# frozen_string_literal: true

require_relative "lib/novu/version"

Gem::Specification.new do |spec|
  spec.name = "novu"
  spec.version = Novu::VERSION
  spec.authors = ["Aman Saini", "Prosper Otemuyiwa", "Kolawole Ezekiel"]
  spec.email = ["prosper@novu.co","amansaini0003@gmail.com", "doneazy911@gmail.com"]

  spec.summary = %q{Client library for Novu API.}
  spec.description = %q{Client library for Novu API.}
  spec.homepage = "https://github.com/novuhq/novu-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/novuhq/novu-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/novuhq/novu-ruby/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  spec.add_dependency "httparty", "~> 0.21"
  spec.add_dependency "activesupport", ">= 6.1.7.2"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
