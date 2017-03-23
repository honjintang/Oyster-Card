

require './lib/journey.rb'
require './lib/station.rb'

class OysterCard

  MAXIMUM_BALANCE = 90
  INITIAL_BALANCE = 5

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
      calculate_fare
      self.single_journey = Journey.new
    end
    fail "Cannot touch in: insufficient funds. Please top up" if balance_insufficient?
    #calculate_fare
    single_journey.add_start(station)
  end

  def touch_out(station)
    if single_journey.nil? || journey_complete?
      calculate_fare
    else
      single_journey.add_finish(station)
      calculate_fare
      finish_trip
    end
  end

  def finish_trip
    journey_history << single_journey
  end

  def calculate_fare
    self.balance += single_journey.fare
  end

  def journey_complete?
    !single_journey.in_journey?
  end

  private

  attr_writer :balance, :entry_station, :single_journey

  def balance_exceeded?(amount_of_money)
    (balance + amount_of_money) > MAXIMUM_BALANCE
  end

  def balance_insufficient?
    balance < 1
  end

end
