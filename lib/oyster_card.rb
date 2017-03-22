

require './lib/journey.rb'
require './lib/station.rb'

class OysterCard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1



attr_reader :balance, :entry_station, :journey_history, :trip

  def initialize
    @balance = 0
    # @entry_station = nil
    @journey_history = []
    @trip = Journey.new
  end

  def top_up(amount_of_money)
    fail "Cannot top up: maximum balance (£#{MAXIMUM_BALANCE}) exceeded" if balance_exceeded?(amount_of_money)
    self.balance += amount_of_money
  end


  # def in_journey?
  #   !!entry_station
  # end

  def touch_in(station)
    fail "Cannot touch in: already in journey" if trip.in_journey?
    fail "Cannot touch in: insufficient funds. Please top up" if balance_insufficient?
    trip.add_start(station)
  end

  def touch_out(station)
    fail "Cannot touch out: not in journey" if !trip.in_journey?
    deduct(MINIMUM_BALANCE)
    trip.add_finish(station)
    trip.store_history
    trip.end_journey
  end


  # journey_history.push(trip)


  private

  def deduct(amount_of_money)
    self.balance -= amount_of_money
  end

  attr_writer :balance, :entry_station, :trip

  def balance_exceeded?(amount_of_money)
    (balance + amount_of_money) > MAXIMUM_BALANCE
  end

  def balance_insufficient?
    balance < MINIMUM_BALANCE
  end

end
