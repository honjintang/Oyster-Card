require 'oyster_card'

describe OysterCard do
  subject(:oyster_card) {described_class.new}

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
      expect {oyster_card.top_up(95)}.to raise_error("Cannot top up: maximum balance (£#{OysterCard::MAX_BALANCE}) exceeded")
    end
  end

  describe "#deduct" do

    it "expects deduct to remove the specificied amount from balance" do
      oyster_card.top_up(20)
      oyster_card.deduct(10)
      expect(oyster_card.balance).to eq(10)
    end

    it "raises exception when user tries to deduct a greater amount of money than is on the card balance" do
      expect { oyster_card.deduct(10) }.to raise_error("Cannot deduct money: insufficient funds")
    end

  end

  # NOW PRIVATE
  # describe "#balance_insufficient?" do
  #
  #   it "returns true when amount to be deducted is more than current balance" do
  #     allow(oyster_card).to receive(:balance) {20}
  #     # oyster_card.top_up(20)
  #     expect(oyster_card.balance_insufficient?(25)).to eq(true)
  #   end
  #
  # end

  describe "#in_journey?" do

    it 'returns false if card is not in journey' do
      expect(oyster_card).not_to be_in_journey
    end

  end

  describe "#touch_in" do

    it 'should return in_journey? as true after oyster has called touch_in' do
      oyster_card.top_up(10)
      oyster_card.touch_in
      expect(oyster_card).to be_in_journey
    end

    it "raise exception when trying to touch_in twice" do
      oyster_card.top_up(10)
      oyster_card.touch_in
      expect { oyster_card.touch_in }.to raise_error("Cannot touch in: already in journey")
    end

    it "prevents the user from travelling with insufficient funds prevent from touching in unless they have a minimum balance of £1" do
      expect{oyster_card.touch_in}.to raise_error 'Cannot touch in: insufficient funds. Please top up'
    end

  end

  describe "#touch_out" do

    it 'should return in_journey as false after oyster on a journey calls touch_out' do
      oyster_card.top_up(10)
      oyster_card.touch_in
      oyster_card.touch_out
      expect(oyster_card).not_to be_in_journey
    end

    it "raise exception when trying to touch_out twice" do
      expect { oyster_card.touch_out }.to raise_error("Cannot touch out: not in journey")
    end


  end

end
