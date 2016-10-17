module Orthographer
  class NoneResult < Result
    def to_s
      "(#{@line}, #{offset}) #{original}"
    end

    private

    def splitted_feedback
      @splitted_feedback ||= @feedback.split ' '
    end

    def offset
      splitted_feedback[2]
    end

    def original
      splitted_feedback[1]
    end
  end
end
