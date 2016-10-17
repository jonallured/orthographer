module Orthographer
  class Result
    def initialize(feedback, line)
      @feedback = feedback
      @line = line
    end

    def to_s
      raise 'Implement in subclass'
    end
  end
end
