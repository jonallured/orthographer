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
      @output ||= `#{cat_cmd} | #{sed_cmd} | #{hunspell_cmd}`
    end

    def cat_cmd
      "cat #{@filename}"
    end

    def sed_cmd
      # turn lines of special characters into blank lines
      "sed 's/^[^[:alnum:]]*$//g'"
    end

    def hunspell_cmd
      'hunspell -a'
    end

    def output_lines
      output.split("\n").map &OutputLine.method(:new)
    end
  end
end
