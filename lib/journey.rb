
# CREATE METHOD TO CALCULATE FARE

class Journey

  def initialize
    @trip = {:start => nil, :finish => nil}
    # @start = nil
    # @finish = nil
  end

  attr_reader :start, :finish, :trip

  def add_start(station)
    self.trip[:start] = station
  end

  def add_finish(station)
    self.trip[:finish] = station
  end

  def in_journey?
    !trip[:finish]
  end
  #
  # def end_journey
  #   self.start = nil
  #   self.finish = nil
  # end

  private

  attr_writer :start, :finish, :trip
end
