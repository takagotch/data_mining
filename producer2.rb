class Producer
  attr_accessor :supply, :price

  def initialize
    @supply, @supply[:chickens], @supply[:ducks] = {}, 0, 0
    @price, @price[:chickens], @price[:ducks]  = {}, 0, 0
  end

  def change_pricing
    @price.each do |type, price|
      if @supply[type] > 0
        @price[type] *= PRICE_DECREMENT unless @price[type] < COST[type]
      else
        @price[type] *= PRICE_INCREMENT
      end
    end
  end

  def generate_goods
    to_produce = Market.average_price(:chickens) > Market.average_price(:ducks) ? :chickens : :ducks
    @supply[to_produce] += (SUPPLY_INCREMENT) if @price[to_produce] > COST[to_produce]
  end

  def produce
    change_pricing
    generate_goods
  end
end

