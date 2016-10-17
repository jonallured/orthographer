module Orthographer
  class Checker
    def self.check(text)
      new(text).check
    end

    def initialize(text)
      @text = text
    end

    def check
      misspellings.flatten.compact
    end

    private

    def output
      @output ||= `echo #{@text} | hunspell -a`
    end

    def line_feedback
      output.sub(/.*\n/, '').split("\n\n")
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

  class MissResult < Result
    def to_s
      "(#{line}, #{character}) #{original}: #{options}"
    end

    private

    def line
      @line
    end

    def character
      @feedback.gsub(/:/, '').split(' ')[3]
    end

    def original
      @feedback.split(' ')[1]
    end

    def options
      @feedback.split(': ').last
    end
  end

  class NoneResult < Result
    def to_s
      "(#{line}, #{character}) #{original}"
    end

    private

    def line
      @line
    end

    def character
      @feedback.gsub(/:/, '').split(' ')[3]
    end

    def original
      @feedback.split(' ')[1]
    end
  end
end
