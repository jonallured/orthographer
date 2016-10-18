require "spec_helper"

describe Orthographer do
  describe '.check' do
    context 'with a good filename' do
      it 'returns those results' do
        filename = 'spec/fixtures/rong.txt'
        results = Orthographer.check filename
        expect(results.count).to eq 1
      end
    end

    context 'with a bad filename' do
      it 'raises an error' do
        filename = 'spec/fixtures/bad.txt'
        expect do
          Orthographer.check(filename)
        end.to raise_error Orthographer::NoFilesFound
      end
    end

    context 'with a glob pattern' do
      it 'returns those results' do
        pattern = 'spec/fixtures/glob_*.txt'
        results = Orthographer.check pattern
        expect(results.count).to eq 2
      end
    end

    context 'with a bad glob pattern' do
      it 'raises an error' do
        pattern = 'spec/fixtures/bad/*.txt'
        expect do
          Orthographer.check(pattern)
        end.to raise_error Orthographer::NoFilesFound
      end
    end
  end
end
