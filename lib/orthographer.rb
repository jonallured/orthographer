require "orthographer/result"
require "orthographer/checker"
require "orthographer/version"

module Orthographer
  def self.check(text)
    Checker.check(text)
  end
end
