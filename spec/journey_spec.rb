require 'journey'

describe Journey do
  let(:london_bridge) {double:station}
  let(:bermondsey) {double:station}
  subject(:journey) {described_class.new}

  describe '#add_start' do
    it 'adds a station to the start of the journey' do
      journey.add_start(london_bridge)
      expect(journey.trip[:start]).to eq london_bridge
    end
  end

  describe '#add_finish' do
    it 'adds a station to the start of the journey' do
      journey.add_finish(london_bridge)
      expect(journey.trip[:finish]).to eq london_bridge
      end
    end

end
