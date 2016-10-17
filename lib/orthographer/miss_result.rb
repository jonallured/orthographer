module Orthographer
  class MissResult < Result
    def to_s
      "(#{line}, #{character}) #{original}: #{options}"
    end

    private

    def line
      @line
    end

    def character
      @feedback.gsub(/:/, '').split(' ')[3]
    end

    def original
      @feedback.split(' ')[1]
    end

    def options
      @feedback.split(': ').last
    end
  end
end
