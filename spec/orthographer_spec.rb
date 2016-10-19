require "spec_helper"

describe Orthographer do
  describe '.check' do
    context 'with a good filename' do
      it 'returns those results' do
        results = Orthographer.check fixtures_path('rong.txt')
        expect(results.count).to eq 1
      end
    end

    context 'with a bad filename' do
      it 'raises an error' do
        expect do
          Orthographer.check fixtures_path('bad.txt')
        end.to raise_error Orthographer::NoFilesFound
      end
    end

    context 'with a glob pattern' do
      it 'returns those results' do
        results = Orthographer.check fixtures_path('glob_*.txt')
        expect(results.count).to eq 2
      end
    end

    context 'with a bad glob pattern' do
      it 'raises an error' do
        expect do
          Orthographer.check fixtures_path('bad/*.txt')
        end.to raise_error Orthographer::NoFilesFound
      end
    end

    context 'with a personal dictionary' do
      it 'ignores words in that dictionary' do
        results = Orthographer.check fixtures_path('jargon.txt'), personal_dict: 'spec/dictionaries/jargon.dic'
        expect(results.first.count).to eq 0
      end
    end

    context 'with a bad personal dictionary' do
      it 'raises an error' do
        expect do
          Orthographer.check fixtures_path('jargon.txt'), personal_dict: 'spec/bad.dic'
        end.to raise_error Orthographer::DictionaryNotFound
      end
    end
  end
end
