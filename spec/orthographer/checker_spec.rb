require 'spec_helper'

module Orthographer
  describe Checker do
    describe '.check' do
      context 'with a word found in the dictionary' do
        it 'returns an empty array' do
          filename = 'spec/fixtures/correct.txt'
          results = Checker.check(filename)
          expect(results.count).to eq 0
        end
      end

      context 'with a word not found in the dictionary' do
        context 'with suggestions' do
          it 'returns a MissResult for that word' do
            filename = 'spec/fixtures/rong.txt'
            results = Checker.check(filename)
            expect(results.count).to eq 1
            expect(results.first).to be_a MissResult
          end
        end

        context 'without suggestions' do
          it 'returns a NoneResult for that word' do
            filename = 'spec/fixtures/no_suggestions.txt'
            results = Checker.check(filename)
            expect(results.count).to eq 1
            expect(results.first).to be_a NoneResult
          end
        end
      end

      context 'with a sentence' do
        it 'returns the right coordinates' do
          filename = 'spec/fixtures/sentence.txt'
          results = Checker.check(filename)
          expect(results.first.coordinates).to eq '(1, 34)'
        end
      end

      context 'with a really weird sentence' do
        it 'returns only the words not found' do
          filename = 'spec/fixtures/weird_sentence.txt'
          results = Checker.check(filename)
          expect(results.count).to eq 2
        end
      end

      context 'with two paragraphs' do
        it 'returns the right coordinates' do
          filename = 'spec/fixtures/two_paragraphs.txt'
          results = Checker.check(filename)
          first, last = *results
          expect(first.coordinates).to eq '(1, 18)'
          expect(last.coordinates).to eq '(3, 11)'
        end
      end

      context 'with no empty lines' do
        it 'returns correct coordinates' do
          filename = 'spec/fixtures/no_empties.txt'
          results = Checker.check(filename)
          first, last = *results
          expect(first.coordinates).to eq '(1, 0)'
          expect(last.coordinates).to eq '(2, 0)'
        end
      end

      context 'with one empty lines' do
        it 'returns correct coordinates' do
          filename = 'spec/fixtures/one_empty.txt'
          results = Checker.check(filename)
          first, last = *results
          expect(first.coordinates).to eq '(1, 0)'
          expect(last.coordinates).to eq '(3, 0)'
        end
      end

      context 'with two empty lines' do
        it 'returns correct coordinates' do
          filename = 'spec/fixtures/two_empties.txt'
          results = Checker.check(filename)
          first, last = *results
          expect(first.coordinates).to eq '(1, 0)'
          expect(last.coordinates).to eq '(4, 0)'
        end
      end

      context 'with 10 empty lines' do
        it 'returns correct coordinates' do
          filename = 'spec/fixtures/ten_empties.txt'
          results = Checker.check(filename)
          first, last = *results
          expect(first.coordinates).to eq '(1, 0)'
          expect(last.coordinates).to eq '(11, 0)'
        end
      end
    end
  end
end
