require 'spec_helper'

module Orthographer
  describe MissResult do
    describe '#to_s' do
      it 'returns the formatted result' do
        feedback = '& rong 15 0: tong, ring, prong, wrong, song, rang, long, dong, rung, gong, pong, bong, Long, Cong, Hong'
        line = 1
        result = MissResult.new(feedback, line)
        expect(result.to_s).to eq '(1, 1) rong: tong, ring, prong, wrong, song, rang, long, dong, rung, gong, pong, bong, Long, Cong, Hong'
      end
    end
  end
end
