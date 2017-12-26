class Producer
  attr_accessor :supply, :price

  def initialize
    @supply, @price = 0,0
  end

  def generate_goods
    @supply += SUPPLY_INCREMENT if @price > COST
  end

  def produce
    if @supply > 0
      @price *= PRICE_DECREMENT unless @price < COST
    else
      @price *= PRICE_INCREMENT
      generate_goods
    end
  end
end

