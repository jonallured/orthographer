require "orthographer/result"
require "orthographer/miss_result"
require "orthographer/none_result"
require "orthographer/output_line"
require "orthographer/checker"
require "orthographer/version"

module Orthographer
  class NoFilesFound < StandardError; end

  def self.check(pattern)
    files = Dir.glob(pattern)
    raise NoFilesFound unless files.any?
    files.map &Checker.method(:check)
  end
end
