
# CREATE METHOD TO CALCULATE FARE

class Journey

  MINIMUM_FARE = -1
  PENALTY_FARE = -6

  attr_reader :fare, :correct_fare

  def initialize
    @trip = {:start => nil, :finish => nil}
    @fare = PENALTY_FARE
  end

  attr_reader :start, :finish, :trip

  def add_start(station)
    self.trip[:start] = station
  end

  def add_finish(station)
    self.trip[:finish] = station
    self.fare = correct_fare
  end

  def reset_fare
    self.fare = PENALTY_FARE
  end

  def correct_fare
    MINIMUM_FARE - (self.trip[:start].zone - self.trip[:finish].zone).abs
  end

  def in_journey?
    !trip[:finish]
  end

  private

  attr_writer :start, :finish, :trip, :fare
end
