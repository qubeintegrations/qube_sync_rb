# frozen_string_literal: true

require "rbconfig"

RSpec.describe "bin/generate-operations" do
  root = File.expand_path("../..", __dir__)
  script = File.join(root, "bin/generate-operations")

  it "--check passes on the committed files" do
    output = IO.popen([RbConfig.ruby, script, "--check"], err: [:child, :out], &:read)
    expect($?.success?).to be(true), output
  end

  it "gives the same output on every run, every file headed as generated" do
    load script unless defined?(GenerateOperations)
    manifest = JSON.parse(File.read(GenerateOperations::MANIFEST, encoding: "UTF-8"))
    first = GenerateOperations::Generator.new(manifest).files
    second = GenerateOperations::Generator.new(JSON.parse(JSON.generate(manifest))).files
    expect(second).to eq(first)
    expect(first.values).to all(start_with(GenerateOperations::HEADER))
    expect(first.keys.grep(%r{\Alib/qube_sync/operations/}).size).to eq(manifest["operations"].map { |op| op["entity"] }.uniq.size)
  end
end
