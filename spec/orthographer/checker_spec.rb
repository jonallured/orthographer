require 'spec_helper'

module Orthographer
  describe Checker do
    describe '.check' do
      context 'with a word found in the dictionary' do
        it 'returns an empty array' do
          results = Checker.check fixtures_path('correct.txt')
          expect(results.count).to eq 0
        end
      end

      context 'with a word not found in the dictionary' do
        context 'with suggestions' do
          it 'returns a MissResult for that word' do
            results = Checker.check fixtures_path('rong.txt')
            expect(results.count).to eq 1
            expect(results.first).to be_a MissResult
          end
        end

        context 'without suggestions' do
          it 'returns a NoneResult for that word' do
            results = Checker.check fixtures_path('no_suggestions.txt')
            expect(results.count).to eq 1
            expect(results.first).to be_a NoneResult
          end
        end
      end

      context 'with a sentence' do
        it 'returns the right coordinates' do
          results = Checker.check fixtures_path('sentence.txt')
          expect(results.first.coordinates).to eq '(1, 35)'
        end
      end

      context 'with a really weird sentence' do
        it 'returns only the words not found' do
          results = Checker.check fixtures_path('weird_sentence.txt')
          expect(results.count).to eq 2
        end
      end

      context 'with two paragraphs' do
        it 'returns the right coordinates' do
          results = Checker.check fixtures_path('two_paragraphs.txt')
          first, last = *results
          expect(first.coordinates).to eq '(1, 19)'
          expect(last.coordinates).to eq '(3, 12)'
        end
      end

      context 'with no empty lines' do
        it 'returns correct coordinates' do
          results = Checker.check fixtures_path('no_empties.txt')
          first, last = *results
          expect(first.coordinates).to eq '(1, 1)'
          expect(last.coordinates).to eq '(2, 1)'
        end
      end

      context 'with one empty lines' do
        it 'returns correct coordinates' do
          results = Checker.check fixtures_path('one_empty.txt')
          first, last = *results
          expect(first.coordinates).to eq '(1, 1)'
          expect(last.coordinates).to eq '(3, 1)'
        end
      end

      context 'with two empty lines' do
        it 'returns correct coordinates' do
          results = Checker.check fixtures_path('two_empties.txt')
          first, last = *results
          expect(first.coordinates).to eq '(1, 1)'
          expect(last.coordinates).to eq '(4, 1)'
        end
      end

      context 'with 10 empty lines' do
        it 'returns correct coordinates' do
          results = Checker.check fixtures_path('ten_empties.txt')
          first, last = *results
          expect(first.coordinates).to eq '(1, 1)'
          expect(last.coordinates).to eq '(11, 1)'
        end
      end

      context 'with lines of special characters' do
        it 'returns correct coordinates' do
          results = Checker.check fixtures_path('special_characters.txt')
          expect(results.first.coordinates).to eq '(3, 18)'
        end
      end

      context 'with empty lines at top' do
        it 'returns correct coordinates' do
          results = Checker.check fixtures_path('empty_lines_at_top.txt')
          expect(results.first.coordinates).to eq '(4, 20)'
        end
      end

      context 'with inline code' do
        it 'returns correct coordinates' do
          results = Checker.check fixtures_path('inline_code.md')
          expect(results.first.coordinates).to eq '(1, 36)'
        end
      end

      context 'with code blocks' do
        it 'returns correct coordinates' do
          results = Checker.check fixtures_path('code_blocks.md')
          expect(results.first.coordinates).to eq '(7, 18)'
        end
      end
    end
  end
end
