module Orthographer
  class MissResult < Result
    def to_s
      "(#{@line}, #{offset}) #{original}: #{options}"
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

    def options
      @feedback.split(': ').last
    end
  end
end
