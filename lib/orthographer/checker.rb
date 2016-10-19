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
      @output ||= `#{commands.join(' | ')}`
    end

    def commands
      [
        cat_cmd,
        first_ruby_cmd,
        sed_cmd,
        ruby_cmd,
        hunspell_cmd
      ]
    end

    def cat_cmd
      "cat #{@filename}"
    end

    def first_ruby_cmd
      # turn code blocks into empty lines
      %q|ruby -e 'puts gets(nil).gsub(/```.*```\n/m) { "\n" * $~.to_s.split("\n").count }'|
    end

    def sed_cmd
      # turn lines of special characters into blank lines
      "sed 's/^[^[:alnum:]]*$//g'"
    end

    def ruby_cmd
      # find inline code and replace the word with 1s
      %q|ruby -pne '$_.gsub!(/`([^`]*)`/) { "`#{?1 * $~[1].length}`" }'|
    end

    def hunspell_cmd
      'hunspell -a'
    end

    def output_lines
      output.split("\n").map &OutputLine.method(:new)
    end
  end
end
