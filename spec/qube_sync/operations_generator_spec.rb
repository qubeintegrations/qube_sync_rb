# frozen_string_literal: true

require "digest"
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
    digest = GenerateOperations.digest(File.binread(GenerateOperations::MANIFEST))
    first = GenerateOperations::Generator.new(manifest, digest: digest).files
    second = GenerateOperations::Generator.new(JSON.parse(JSON.generate(manifest)), digest: digest).files
    expect(second).to eq(first)
    expect(first.values).to all(start_with(GenerateOperations::HEADER))
    expect(first["lib/qube_sync/operations.rb"]).to include("DIGEST = #{digest.inspect}")
    expect((first.keys.grep(%r{\Alib/qube_sync/operations/}) - [GenerateOperations::FIELDS_FILE]).size).to eq(manifest["operations"].map { |op| op["entity"] }.uniq.size)
  end

  it "gives the index the manifest's digest, as QuBe Sync serves it" do
    bytes = File.binread(File.join(root, "spec/fixtures/operations.json"))
    expect(QubeSync::Operations::DIGEST).to eq("sha256:#{Digest::SHA256.hexdigest(bytes)}")
  end
end
