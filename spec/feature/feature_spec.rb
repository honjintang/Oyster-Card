describe "User Stories" do

let(:oyster_card) { OysterCard.new }
let(:oyster_card_topped_up) {(OysterCard.new).top_up(10)}
let(:london_bridge) { Station.new("London Bridge", 2)}
let(:bermondsey) { Station.new("Bermondsey", 2) }
# In order to use public transport
# As a customer
# I want money on my card

  it "so customer can check balance, return balance" do
    expect(oyster_card).to respond_to(:balance)
  end

  # In order to keep using public transport
  # As a customer
  # I want to add money to my card

  it "so user can add money to their card, add top up functionality" do
    oyster_card.top_up(20)
    expect(oyster_card.balance).to eq(25)
  end

  # In order to protect my money from theft or loss
  # As a customer
  # I want a maximum limit (of £90) on my card

  it 'so users money is safe, limit maximum balance on card to £90' do
    oyster_card.top_up(OysterCard::MAXIMUM_BALANCE - OysterCard::INITIAL_BALANCE)
    expect {oyster_card.top_up(1)}.to raise_error("Cannot top up: maximum balance (£#{OysterCard::MAXIMUM_BALANCE}) exceeded")
  end

  # In order to pay for my journey
  # As a customer
  # I need my fare deducted from my card

  # it "so user can spend money, allow transactions to occur until there is £0 card balance" do
  #     5.times do
  #       oyster_card.touch_in(london_bridge)
  #       oyster_card.touch_out(bermondsey)
  #     end
  #     expect { oyster_card.touch_in(london_bridge) }.to raise_error("Cannot touch in: insufficient funds. Please top up")
  #
  # end

  # In order to get through the barriers.
  # As a customer
  # I need to touch in and out.

  it 'so the user can be chardged the correct amount for their journey, they should be able to touch in and out and have minimum fare deducted.' do
    oyster_card.touch_in(london_bridge)
    oyster_card.touch_out(bermondsey)
    expect(oyster_card.balance).to eq(OysterCard::INITIAL_BALANCE + Journey::MINIMUM_FARE)

  end

  #In order to pay for my journey
  # As a customer
  # I need to have the minimum amount (£1) for a single journey.

  it "to prevent the user from travelling with insufficient funds prevent from touching in unless they have a minimum balance of £1" do
    allow(oyster_card).to receive(:balance){0}
    expect{oyster_card.touch_in(london_bridge)}.to raise_error 'Cannot touch in: insufficient funds. Please top up'
  end

  #   In order to pay for my journey
  # As a customer
  # When my journey is complete, I need the correct amount deducted from my card

  it 'deduct minimum fare from balance when touching out.' do
    oyster_card.touch_in(london_bridge)
    expect {oyster_card.touch_out(bermondsey)}.to change{oyster_card.balance}.by Journey::MINIMUM_FARE
  end

  #In order to pay for my journey
  # As a customer
  # I need to know where I've travelled from

  # it 'will record the station where the user touches in' do
  #   oyster_card.touch_in(london_bridge)
  #   expect(oyster_card.single_journey.trip[:start]).to eq london_bridge
  # end

  #   In order to know where I have been
  # As a customer
  # I want to see to all my previous trips

#   it 'will record entry station and exit station, and return journey history.' do
#     oyster_card.touch_in(london_bridge)
#     oyster_card.touch_out(bermondsey)
#     expect(oyster_card.journey_history[0].trip).to include ({:start => london_bridge, :finish => bermondsey})
#   end
# end
  # In order to know how far I have travelled
  # As a customer
  # I want to know what zone a station is in

end 
