
# CREATE METHOD TO CALCULATE FARE

class Journey

  def initialize
    @start = nil
    @finish = nil
    @journey_history = []
  end

  attr_reader :start, :finish, :journey_history

  def add_start(station)
    self.start = station
  end

  def add_finish(station)
    self.finish = station
  end

  def in_journey?
    !!start
  end

  def end_journey
    self.start = nil
    self.finish = nil
  end

  def store_history
    self.journey_history << {start => finish}
  end

  private

  attr_writer :start, :finish
end
