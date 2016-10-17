require "spec_helper"

describe Orthographer do
  it "has a version number" do
    expect(Orthographer::VERSION).not_to be nil
  end

  it 'finds a spelling mistake' do
    text = 'rong'
    misspellings = Orthographer.check text
    expect(misspellings.count).to eq 1
  end
end
