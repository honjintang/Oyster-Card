class OysterCard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1


attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount_of_money)
    fail "Cannot top up: maximum balance (£#{MAXIMUM_BALANCE}) exceeded" if balance_exceeded?(amount_of_money)
    self.balance += amount_of_money
  end



  def in_journey?
    in_journey
  end

  def touch_in
    fail "Cannot touch in: already in journey" if in_journey?
    fail "Cannot touch in: insufficient funds. Please top up" if balance_insufficient?
    self.in_journey = true
  end

  def touch_out
    fail "Cannot touch out: not in journey" if !in_journey?
    self.in_journey = false
    deduct(MINIMUM_BALANCE)
  end

  private

  def deduct(amount_of_money)
    self.balance -= amount_of_money
  end

  attr_accessor :in_journey

  attr_writer :balance

  def balance_exceeded?(amount_of_money)
    (balance + amount_of_money) > MAXIMUM_BALANCE
  end

  def balance_insufficient?
    balance < MINIMUM_BALANCE
  end

end
