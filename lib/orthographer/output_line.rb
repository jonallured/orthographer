module Orthographer
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
      sign_result_map[sign]
    end

    def sign_result_map
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
