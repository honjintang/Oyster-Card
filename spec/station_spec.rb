require 'station'

describe Station do

subject(:station) {described_class.new(:london_bridge,:one)}

  describe '#initialize' do
    it 'creates an instance of Station & initializes it with a name' do
      expect(station.name).to eq :london_bridge
    end
    it 'creates an instance of Station & initializes it with a zone' do
      expect(station.zone).to eq :one
    end
  end
end
