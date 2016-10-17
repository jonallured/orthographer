require "orthographer/result"
require "orthographer/miss_result"
require "orthographer/none_result"
require "orthographer/checker"
require "orthographer/version"

module Orthographer
  def self.check(text)
    Checker.check(text)
  end
end
