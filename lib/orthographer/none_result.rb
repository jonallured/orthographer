module Orthographer
  class NoneResult < Result
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
