require 'spec_helper'

module Orthographer
  describe NoneResult do
    describe '#to_s' do
      it 'returns the formatted result' do
        feedback = '# qqxxqqxxqqxxqqxxqq 0'
        line = 1
        result = NoneResult.new(feedback, line)
        expect(result.to_s).to eq '(1, 0) qqxxqqxxqqxxqqxxqq'
      end
    end
  end
end
