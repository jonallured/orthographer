module Orthographer
  class MissResult < Result
    def to_s
      "#{super.to_s}: #{suggestions}"
    end

    private

    def splitted_feedback
      @splitted_feedback ||= @feedback.gsub(/:/, '').split ' '
    end

    def offset
      splitted_feedback[3]
    end

    def original
      splitted_feedback[1]
    end

    def suggestions
      @feedback.split(': ').last
    end
  end
end
