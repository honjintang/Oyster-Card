

require './lib/journey.rb'
require './lib/station.rb'
require './lib/journey_log.rb'

class OysterCard

  MAXIMUM_BALANCE = 90
  INITIAL_BALANCE = 5

attr_reader :balance, :entry_station, :journey_history, :single_journey, :journey_log

  def initialize
    @balance = INITIAL_BALANCE
    @journey_log = JourneyLog.new(Journey)

  end

  def top_up(amount_of_money)
    fail "Cannot top up: maximum balance (£#{MAXIMUM_BALANCE}) exceeded" if balance_exceeded?(amount_of_money)
    self.balance += amount_of_money
  end

  def touch_in(station)
    if no_journey?
      journey_log.start
    elsif !in_journey?
      journey_log.start
    else
      calculate_fare
      journey_log.start
    end
    fail "Cannot touch in: insufficient funds. Please top up" if balance_insufficient?
    journey_log.add_start(station)
  end

  def touch_out(station)
    if no_journey?
      self.balance += Journey::PENALTY_FARE
    elsif ! in_journey?
      journey_log.current_journey.reset_fare
      calculate_fare
    else
      journey_log.finish(station)
      calculate_fare
    end
  end

  def calculate_fare
    self.balance += journey_log.current_journey.fare
  end

  def in_journey?
    journey_log.current_journey.in_journey?
  end

  def no_journey?
    journey_log.current_journey.nil?
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
