# frozen_string_literal: true

require_relative "lib/qube_sync/version"

Gem::Specification.new do |spec|
  spec.name = "qube_sync"
  spec.version = QubeSync::VERSION
  spec.authors = ["Garrett Lancaster"]
  spec.email = ["support@qubesync.com"]

  spec.summary = "Ruby library for the QUBE Sync API"
  spec.description = """
  Easily create and manage QUBE Sync API resources in Ruby.

  Manage connections, queued requests, and more with the QUBE Sync API.
  """
  spec.homepage = "https://github.com/qubeintegrations/qube_sync_rb"
  spec.required_ruby_version = ">= 2.6.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/qubeintegrations/qube_sync_rb"
  spec.metadata["changelog_uri"] = "https://github.com/qubeintegrations/qube_sync_rb/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "faraday"


  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
