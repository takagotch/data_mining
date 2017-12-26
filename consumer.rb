class Consumer
  attr_accessor :demands

  def initialize
    @demands = 0
  end

  def buy
    until @demands <= 0 Market.supply <= 0
     cheapest_producer = Market.cheapest_producer

     if cheapest_producer
       @demands *= 0.5 if cheapest_producer.price > MAX_ACCEPTABLE_PRICE
       cheapest_supply = cheapest_producer.supply

       if @demands > cheapest_supply
         @demands -= chepest_supply
	 cheapest_producer.supply = 0
       else
         chepest_produce.supply -= @demands
	 @dmands = 0
       end
     end
    end
  end
end


