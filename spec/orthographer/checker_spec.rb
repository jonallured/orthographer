require 'spec_helper'

module Orthographer
  describe Checker do
    describe '.check' do
      context 'with a word found in the dictionary' do
        it 'returns an empty array' do
          text = 'correct'
          misspellings = Checker.check(text)
          expect(misspellings.count).to eq 0
        end
      end

      context 'with a word not found in the dictionary' do
        context 'with suggestions' do
          it 'returns a MissResult for that word' do
            text = 'rong'
            misspellings = Checker.check(text)
            expect(misspellings.count).to eq 1
            expect(misspellings.first).to be_a MissResult
          end
        end

        context 'without suggestions' do
          it 'returns a NoneResult for that word' do
            text = 'qqxxqqxxqqxxqqxxqq'
            misspellings = Checker.check(text)
            expect(misspellings.count).to eq 1
            expect(misspellings.first).to be_a NoneResult
          end
        end
      end

      context 'with a really weird sentence' do
        it 'returns only the words not found' do
          text = 'Wow, rong qqxxqqxxqqxxqqxxqq I guess!'
          misspellings = Checker.check(text)
          expect(misspellings.count).to eq 2
        end
      end
    end
  end
end
