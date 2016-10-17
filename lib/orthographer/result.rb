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
      "(#{@line}, #{offset})"
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
