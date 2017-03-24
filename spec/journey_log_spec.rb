require 'journey_log'

describe JourneyLog do
  let(:journey){ double :journey, trip: {:start => nil, :finish => nil}, add_start: nil, add_finish: station }
  let(:station){ double :station }
  let(:journey_class){ double :journey_class, new: journey }
  subject(:journey_log) {described_class.new(journey_class)}

  it "starts a new journey with an entry station" do
    expect(journey_log.start).to eq journey
  end

  describe "#add_start" do

    it "adds start station to journey" do
      journey_log.start
      journey_log.add_start(station)
      expect(journey).to have_received(:add_start).with(station)
    end
  end

  describe "#finish" do
    it "adds an extra station to the journey" do
      journey_log.start
      journey_log.add_start(station)
      journey_log.finish(station)
      expect(journey).to have_received(:add_finish).with(station)
    end
  end

  describe "#journeys" do
    it "returns a list of all previous journeys" do
      journey_log.start
      journey_log.add_start(station)
      journey_log.finish(station)
      expect(journey_log.journeys).to include journey
    end
  end

end
