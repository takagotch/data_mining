class Market
  def self.average_price
    ($producers.inject(0.0) { |memo, producer| memo + producer.price}/
       $producer.size).round(2)
  end

  def self.supply
    $producers.inject(0) {|memo, producer| memo + producer.supply }
  end

  def self.demand
    $consumers.inject(0) {|memo, consumer| memo + consumer.demands }
  end

  def self.cheapest_producer
    producers = $producers.find_all {|f| f.supply > 0}
    producers.min_by {|f| f.price}
  end
end

