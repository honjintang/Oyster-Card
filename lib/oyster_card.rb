

require './lib/journey.rb'
require './lib/station.rb'

class OysterCard

  MAXIMUM_BALANCE = 90
  INITIAL_BALANCE = 5
  MINIMUM_FARE = 1
  PENALTY_FARE = 6



attr_reader :balance, :entry_station, :journey_history, :single_journey

  def initialize
    @balance = INITIAL_BALANCE
    # @entry_station = nil
    @journey_history = []

  end

  def top_up(amount_of_money)
    fail "Cannot top up: maximum balance (£#{MAXIMUM_BALANCE}) exceeded" if balance_exceeded?(amount_of_money)
    self.balance += amount_of_money
  end

  def touch_in(station)
    if single_journey.nil?
      self.single_journey = Journey.new
    elsif journey_complete?
      self.single_journey = Journey.new
    else
      deduct(PENALTY_FARE)
      self.single_journey = Journey.new
    end
    fail "Cannot touch in: insufficient funds. Please top up" if balance_insufficient?
    single_journey.add_start(station)
  end

  def touch_out(station)
    if single_journey.nil? || journey_complete?
      deduct(PENALTY_FARE)
    else
    single_journey.add_finish(station)
    deduct(MINIMUM_FARE)
    finish_trip
    end
  end

  def finish_trip
    journey_history << single_journey
  end

  # def fare
  #   if journey_complete?
  #       deduct(MINIMUM_BALANCE)
  #   else
  #   deduct(PENALTY_FARE)
  # end
  # end

  def journey_complete?
    !single_journey.in_journey?
  end

  private

  def deduct(amount_of_money)
    self.balance -= amount_of_money
  end

  attr_writer :balance, :entry_station, :single_journey

  def balance_exceeded?(amount_of_money)
    (balance + amount_of_money) > MAXIMUM_BALANCE
  end

  def balance_insufficient?
    balance < MINIMUM_FARE
  end

end
