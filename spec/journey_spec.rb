require 'journey'

describe Journey do
  let(:london_bridge) {double:station, zone: 2}
  let(:bermondsey) {double:station, zone: 3}
  subject(:journey) {described_class.new}

  describe '#add_start' do
    it 'adds a station to the start of the journey' do
      journey.add_start(london_bridge)
      expect(journey.trip[:start]).to eq london_bridge
    end
  end

  describe '#add_finish' do
    it 'adds a station to the end of the journey' do
      journey.add_start(london_bridge)
      journey.add_finish(london_bridge)
      expect(journey.trip[:finish]).to eq london_bridge
      end
    end

  describe '#correct_fare' do
    it 'returns the correct fare for a journey' do
      journey.add_start(london_bridge)
      journey.add_finish(bermondsey)
      expect(journey.correct_fare).to eq -2
    end
  end

end
