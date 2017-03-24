require 'oyster_card'

describe OysterCard do
  subject(:oyster_card) {described_class.new}
  let(:london_bridge) {double:station}
  let(:bermondsey) {double:station}

  describe '#balance' do
  it 'responds to balance enquiry' do
    expect(oyster_card).to respond_to(:balance)
  end

  it "new instance has £5 balance by default" do
    expect(oyster_card.balance).to eq(OysterCard::INITIAL_BALANCE)
  end
end

  describe '#top_up' do

    it 'expects to receive top_up with an argument and update balance' do
      oyster_card.top_up(20)
      expect(oyster_card.balance).to eq(25)
    end

    it 'expects to top_up to add amount to existing balance' do
      oyster_card.top_up(20)
      oyster_card.top_up(20)
      expect(oyster_card.balance).to eq (45)
    end

    it 'expects top up after maximum balance reached to return error' do
      expect {oyster_card.top_up(90)}.to raise_error("Cannot top up: maximum balance (£#{OysterCard::MAXIMUM_BALANCE}) exceeded")
    end
  end

  describe "#touch_in" do

    it "prevents the user from travelling with insufficient funds prevent from touching in unless they have a minimum balance of £1" do
      5.times do
        oyster_card.touch_in(london_bridge)
        oyster_card.touch_out(bermondsey)
      end
      expect{oyster_card.touch_in(london_bridge)}.to raise_error 'Cannot touch in: insufficient funds. Please top up'
    end

    xit 'allows the user to see what station they touched in at' do
      oyster_card.touch_in(london_bridge)
      oyster_card.touch_out(bermondsey)
      expect(oyster_card.journey_history[0].trip[:start]).to eq london_bridge
    end
  end

  describe "#touch_out" do

    # it 'should return in_journey as false after oyster on a journey calls touch_out' do
    #   oyster_card.touch_in(london_bridge)
    #   oyster_card.touch_out(bermondsey)
    #   expect(oyster_card.single_journey).not_to be_in_journey
    # end

    it 'deduct minimum fare from balance when touching out.' do
      oyster_card.touch_in(london_bridge)
      expect {oyster_card.touch_out(bermondsey)}.to change{oyster_card.balance}.by Journey::MINIMUM_FARE
    end
  end

  describe"#journey_history" do
    xit 'will record entry station and exit station, and return journey history.' do
      oyster_card.touch_in(london_bridge)
      oyster_card.touch_out(bermondsey)
      expect(oyster_card.journey_history[0].trip).to eq ({:start => london_bridge, :finish => bermondsey})
    end
  end

  describe"#fare" do
    it 'will deduct minimum fare for complete journeys' do
      oyster_card.touch_in(london_bridge)
      oyster_card.touch_out(bermondsey)
      expect(oyster_card.balance).to eq (OysterCard::INITIAL_BALANCE + Journey::MINIMUM_FARE)
    end

    it "will deduct penalty fare if user touches in but doesn't touch out" do
      oyster_card.top_up(10)
      oyster_card.touch_in(london_bridge)
      oyster_card.touch_in(london_bridge)
      expect(oyster_card.balance).to eq ((10 + OysterCard::INITIAL_BALANCE) + Journey::PENALTY_FARE)
    end

    it "will deduct penalty fare if user touches out without ever touching in" do
      oyster_card.touch_out(bermondsey)
      expect(oyster_card.balance).to eq (OysterCard::INITIAL_BALANCE + Journey::PENALTY_FARE)
    end
  end

end
