require "orthographer/result"
require "orthographer/miss_result"
require "orthographer/none_result"
require "orthographer/output_line"
require "orthographer/checker"
require "orthographer/version"

module Orthographer
  class NoFilesFound < StandardError; end
  class DictionaryNotFound < StandardError; end

  def self.check(pattern, personal_dict: nil)
    files = Dir.glob(pattern)
    raise NoFilesFound unless files.any?
    raise DictionaryNotFound unless personal_dict.nil? || File.exist?(personal_dict)
    files.map { |file| Checker.check(file, personal_dict: personal_dict) }
  end
end
