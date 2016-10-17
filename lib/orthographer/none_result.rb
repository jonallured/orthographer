module Orthographer
  class NoneResult < Result
    def to_s
      "(#{line}, #{character}) #{original}"
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
  end
end
