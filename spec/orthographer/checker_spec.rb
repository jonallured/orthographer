require 'spec_helper'

module Orthographer
  describe Checker do
    describe '.check' do
      context 'with a correct word' do
        it 'returns an empty array' do
          text = 'correct'
          misspellings = Checker.check(text)
          expect(misspellings.count).to eq 0
        end
      end

      context 'with an incorrect word' do
        it 'returns a misspelling for that word' do
          text = 'rong'
          misspellings = Checker.check(text)
          expect(misspellings.count).to eq 1
        end
      end

      context 'with an incorrect sentence' do
        it 'returns a misspelling for each word' do
          text = 'Thi ist verry rong.'
          misspellings = Checker.check(text)
          expect(misspellings.count).to eq 4
        end
      end
    end
  end
end
