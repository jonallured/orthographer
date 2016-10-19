$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "orthographer"

module FixtureHelpers
  def fixtures_path(filename)
    "spec/fixtures/#{filename}"
  end
end

RSpec.configure do |config|
  config.include(FixtureHelpers)
end
