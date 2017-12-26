class Consumer
  attr_accessor :demands

  def initialize
    @demands = 0
  end

  def buy(type)
    until @demands <= 0 or Market.supply(type) <= 0
      cheapest_producer = Market.cheapest_producer(type)

      if cheapest_producer
        @demands *= 0.5 if cheapest_producer.price[type] > MAX_ACCEPTABLE_PRICE[type]
	cheapest_supply = cheapest_producer.supply[type]

	if @demands > cheapest_supply then
	  @demands -= cheapest_supply
	  cheapest_producer.supply[type] = 0
	else
	  chepest_producer.supply[type] -= @demands
	  @demands = 0
	end
      end
    end
  end

end

