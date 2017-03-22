class OysterCard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1


attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount_of_money)
    fail "Cannot top up: maximum balance (£#{MAXIMUM_BALANCE}) exceeded" if balance_exceeded?(amount_of_money)
    self.balance += amount_of_money
  end


  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    fail "Cannot touch in: already in journey" if in_journey?
    fail "Cannot touch in: insufficient funds. Please top up" if balance_insufficient?
    self.entry_station = station
  end

  def touch_out
    fail "Cannot touch out: not in journey" if !in_journey?
    deduct(MINIMUM_BALANCE)
    self.entry_station = nil
  end

  private

  def deduct(amount_of_money)
    self.balance -= amount_of_money
  end

  attr_writer :balance, :entry_station

  def balance_exceeded?(amount_of_money)
    (balance + amount_of_money) > MAXIMUM_BALANCE
  end

  def balance_insufficient?
    balance < MINIMUM_BALANCE
  end

end
