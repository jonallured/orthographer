module Orthographer
  class Checker
    def self.check(filename, personal_dict: nil)
      new(filename, personal_dict: personal_dict).check
    end

    def initialize(filename, personal_dict: nil)
      @filename = filename
      @personal_dict = personal_dict
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
        cat_file,
        remove_code_blocks,
        remove_special_character_lines,
        mask_inline_code,
        check_spelling
      ]
    end

    def cat_file
      "cat #{@filename}"
    end

    def remove_code_blocks
      %q|ruby -e 'puts gets(nil).gsub(/```.*```\n/m) { "\n" * $~.to_s.split("\n").count }'|
    end

    def remove_special_character_lines
      "sed 's/^[^[:alnum:]]*$//g'"
    end

    def mask_inline_code
      %q|ruby -pne '$_.gsub!(/`([^`]*)`/) { "`#{?1 * $~[1].length}`" }'|
    end

    def check_spelling
      command = 'hunspell -a'
      command << " -p #{@personal_dict}" if @personal_dict
      command
    end

    def output_lines
      output.split("\n").map &OutputLine.method(:new)
    end
  end
end
