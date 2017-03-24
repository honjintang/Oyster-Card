class JourneyLog

  attr_reader :journey_class, :journeys, :current_journey

  def initialize(journey_class)
    @journey_class = journey_class
    @journeys = []
  end

  def start
    @current_journey = journey_class.new
  end

  def add_start(station)
    current_journey.add_start(station)
  end

  def finish(station)
    current_journey.add_finish(station)
    journeys << current_journey
  end

  #private

 #def current_journey

  # @current_journey ||= @current_journey = journey_class.new

  #  if @current_journey == nil
  #    @current_journey = journey_class.new
  #  else
  #    @current_journey
  #  end
 #end

end
