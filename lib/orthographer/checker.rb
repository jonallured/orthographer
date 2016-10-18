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
        if output_line.miss?
          results << MissResult.new(output_line.text, @line)
        elsif output_line.none?
          results << NoneResult.new(output_line.text, @line)
        elsif output_line.empty?
          @line += 1
        end
      end

      results
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
    attr_accessor :text

    def initialize(text)
      @text = text
    end

    def miss?
      text[0] == '&'
    end

    def none?
      text[0] == '#'
    end

    def empty?
      text == ''
    end
  end
end
