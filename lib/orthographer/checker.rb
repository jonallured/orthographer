module Orthographer
  class Checker
    def self.check(filename)
      new(filename).check
    end

    def initialize(filename)
      @filename = filename
      @line = 1
    end

    def check
      results = []

      for output_line in output_lines
        results << output_line.result_for(@line)
        @line += 1 if output_line.empty?
      end

      results.compact
    end

    private

    def output
      @output ||= `cat #{@filename} | hunspell -a`
    end

    def output_lines
      output.split("\n").map &OutputLine.method(:new)
    end
  end

  class OutputLine
    def initialize(text)
      @text = text
    end

    def result_for(line)
      return nil unless result?
      result_klass.new @text, line
    end

    def empty?
      @text == ''
    end

    private

    def result?
      !!result_klass
    end

    def result_klass
      mapping[sign]
    end

    def mapping
      {
        '&' => MissResult,
        '#' => NoneResult
      }
    end

    def sign
      @text[0]
    end
  end
end
