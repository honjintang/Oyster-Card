require 'oyster_card'

describe OysterCard do
  subject(:oyster_card) {described_class.new}
  let(:london_bridge) {double:station}
  let(:bermondsey) {double:station}

  describe '#balance' do
  it 'responds to balance enquiry' do
    expect(oyster_card).to respond_to(:balance)
  end

  it "new instance has zero balance by default" do
    expect(oyster_card.balance).to eq(0)
  end
end

  describe '#top_up' do

    it 'expects to receive top_up with an argument and update balance' do
      oyster_card.top_up(20)
      expect(oyster_card.balance).to eq(20)
    end

    it 'expects to top_up to add amount to existing balance' do
      oyster_card.top_up(20)
      oyster_card.top_up(20)
      expect(oyster_card.balance).to eq (40)
    end

    it 'expects top up after maximum balance reached to return error' do
      expect {oyster_card.top_up(95)}.to raise_error("Cannot top up: maximum balance (£#{OysterCard::MAXIMUM_BALANCE}) exceeded")
    end
  end

  describe "#in_journey?" do

    it 'returns false if card is not in journey' do
      expect(oyster_card).not_to be_in_journey
    end

  end

  describe "#touch_in" do

    it 'should return in_journey? as true after oyster has called touch_in' do
      oyster_card.top_up(10)
      oyster_card.touch_in(london_bridge)
      expect(oyster_card).to be_in_journey
    end

    it "raise exception when trying to touch_in twice" do
      oyster_card.top_up(10)
      oyster_card.touch_in(london_bridge)
      expect { oyster_card.touch_in(london_bridge) }.to raise_error("Cannot touch in: already in journey")
    end

    it "prevents the user from travelling with insufficient funds prevent from touching in unless they have a minimum balance of £1" do
      expect{oyster_card.touch_in(london_bridge)}.to raise_error 'Cannot touch in: insufficient funds. Please top up'
    end

    it 'will record the station where the user touches in' do
      oyster_card.top_up(10)
      oyster_card.touch_in(london_bridge)
      expect(oyster_card.entry_station).to eq london_bridge
    end
  end

  describe "#touch_out" do

    it 'should return in_journey as false after oyster on a journey calls touch_out' do
      oyster_card.top_up(10)
      oyster_card.touch_in(london_bridge)
      oyster_card.touch_out(bermondsey)
      expect(oyster_card).not_to be_in_journey
    end

    it "rasie exception when user tries to touch out without touching in" do
      expect { oyster_card.touch_out(bermondsey) }.to raise_error("Cannot touch out: not in journey")
    end

    it 'deduct minimum fare from balance when touching out.' do
      oyster_card.top_up(10)
      oyster_card.touch_in(london_bridge)
      expect {oyster_card.touch_out(bermondsey)}.to change{oyster_card.balance}.by -OysterCard::MINIMUM_BALANCE
    end

    it 'checks that entry_station is set to nil after touching out' do
      oyster_card.top_up(10)
      oyster_card.touch_in(london_bridge)
      expect {oyster_card.touch_out(bermondsey)}.to change{oyster_card.entry_station}.to nil
    end
  end

  describe"#journey_history" do
    it 'will record entry station and exit station, and return journey history.' do
      oyster_card.top_up(10)
      oyster_card.touch_in(london_bridge)
      oyster_card.touch_out(bermondsey)
      expect(oyster_card.journey_history).to include ({london_bridge => bermondsey})
    end


  end

end
