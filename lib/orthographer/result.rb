module Orthographer
  class Result
    def initialize(feedback, line)
      @feedback = feedback
      @line = line
    end

    def to_s
      "#{coordinates} #{original}"
    end

    def coordinates
      "(#{@line}, #{offset.to_i + 1})"
    end

    private

    def offset
      raise 'Implement in subclass'
    end

    def original
      raise 'Implement in subclass'
    end
  end
end
