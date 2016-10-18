module Orthographer
  class Checker
    def self.check(filename)
      new(filename).check
    end

    def initialize(filename)
      @filename = filename
    end

    def check
      misspellings.flatten.compact
    end

    private

    def output
      @output ||= `cat #{@filename} | hunspell -a`
    end

    def line_feedback
      without_version_info = output.sub /.*\n/, ''
      # remove trailing newlines when they are followed by another newline
      without_trailing_newlines = without_version_info.gsub /(\w)\n(\n)/, '\1\2'
      without_trailing_newlines.split "\n"
    end

    def misspellings
      line_feedback.map.with_index do |feedback, index|
        word_feedback = feedback.split("\n")
        word_feedback.map do |word|
          if word[0] == "&"
            MissResult.new(word, index + 1)
          elsif word[0] == "#"
            NoneResult.new(word, index + 1)
          end
        end
      end
    end
  end
end
