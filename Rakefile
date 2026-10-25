# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task default: :spec

namespace :operations do
  desc "Write the per-operation methods and signatures from spec/fixtures/operations.json"
  task :generate do
    ruby "bin/generate-operations"
  end

  desc "Fail when the generated operations are stale, missing or orphaned"
  task :check do
    ruby "bin/generate-operations", "--check"
  end
end
