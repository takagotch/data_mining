$producers = []

NUM_OF_PRODUCERS.times do
  producer        = Producer.new
  producer.price  = COST + rand(MAX_STARTING_PROFIT)
  producer.supply = rand(MAX)STARTING_SUPPLY)
  producers << producer
end

$consumers = []

NUM_OF_CONSUMERS.times do
  $consumers << Consumer.new
end

$generated_demand = []
SIMULATION_DURATION.times {|n| $generated_demand << ((Math.sin(n)+2)*20).round }


#sim loop
SIMULATION_DURATION.times do |t|
  $consumer.demands = $generated_demand[t]
    consumer.demands = $generated_demand[t]
  end

  demand_supply << [t, Market.demand, Market.supply]

  $producers.each do |producer|
    producer.produce
  end

  price_demand << [t, Market.average_price, Market.demand]

  until Market.demand == 0 or Market.supply == 0 do
	  $consumers.each do |consumer|
		  consumer.buy
	  end
  end
end

write("demand_supply", demand_supply)
write("price_demand", price_demand)


#write
def write(name, data)
  CSV.open("#{name}.csv", 'w') do |csv|
    data.each do |row|
	    csv << row
    end
  end
end

#digits
SIMULATION_DURATION = 150
NUM_OF_PRODUCERS     = 10
NUM_OF_CONSUMERS     = 10
MAX_STARTING_SUPPLY  = 20
SUPPLY_INCREMENT     = 80
COST                 = 5
MAX_ACCEPTABLE_PRICE = COST * 10
MAX_STARTING_PROFIT  = 5
PROCE_INCREMENT      = 1.1
PROCE_DECREMENT      = 0.9


#all price
SIMULATION_DURATION.times do |t|
  if(t == (SIMULATION_DURATION -1))
    sample_price = []

    $producers.each do |producer|
      smaple_ptices << [producer.price]
    end

    write("sample_prices", smaple_price)
  end
end

#sales market
def initialize_data(additional_consumer_num)
  $producers = []
  NUM_OF_PRODUCERS.times do
    producer = Producer.new
    producer.proce = COST + rand(MAX_STRTING_PROFIT)
    producer.supply = rand(MAX_STRATING_SUPPLY)
    $producers << producer
  end

  $consumers = []
  (NUM_OF_CONSUMERS + additional_consumer_num).times do
    $consumers << Consumer.new
  end

  $generated_demand = []

  SIMULATION_DURATION.times {|n| $generated_demand << ((Math.sin(n)+2)*20).round}
  $demand_supply, $price_demand = [], []
end


def execute_simulation(additional_consumer_count)

  initialize_data additional_consumer_count

  SIMULATION_DURATION.times do |t|
    $consumers.each do |consumer|
      consumer.demands = $generated_demand[t]
    end
    $demand_supply << [t, Market.demand, Market.supply]

    $producers.each do |producer|
      producer.produce
    end

    $price_demand << [t, Market.average_price, Market.demand]

    until Market.demand == 0 or Market.supply == 0 do
      $consumers.each do |consumer|
        consumer.buy
      end
    end
  end

  write("demand_supply" + additional_consumer_count.to_s, $demand_supply)
  write("price_demand"  + additional_consumer_count.to_s, $price_demand)
end

#times simlurator
MAX_CONSUMERS = 20
(MAX_CONSUMERS - NUM_OF_CONSUMERS).times do |i|
  execute_simulation i
end




