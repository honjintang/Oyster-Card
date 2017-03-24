

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
    # @entry_station = nil
    #@journey_history = []

  end

  def top_up(amount_of_money)
    fail "Cannot top up: maximum balance (£#{MAXIMUM_BALANCE}) exceeded" if balance_exceeded?(amount_of_money)
    self.balance += amount_of_money
  end

  def touch_in(station)
    if journey_log.current_journey.nil?
      #single_journey.nil?
      journey_log.start
      #self.single_journey = Journey.new
    elsif !journey_log.current_journey.in_journey?
      #journey_complete?
      journey_log.start
      #self.single_journey = Journey.new
    else
      calculate_fare
      journey_log.start
      #self.single_journey = Journey.new
    end
    fail "Cannot touch in: insufficient funds. Please top up" if balance_insufficient?
    #calculate_fare
    journey_log.add_start(station)
    #single_journey.add_start(station)
  end

  def touch_out(station)
    if journey_log.current_journey.nil?
      #single_journey.nil?
      self.balance += Journey::PENALTY_FARE
    elsif ! journey_log.current_journey.in_journey?
      #journey_complete?
      journey_log.current_journey.reset_fare
      calculate_fare
    else
      journey_log.finish(station)
      #single_journey.add_finish(station)
      calculate_fare
      #finish_trip
    end
  end

  #def finish_trip
    #journey_history << single_journey
  #end

  def calculate_fare
    self.balance += journey_log.current_journey.fare
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
