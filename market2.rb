class Market
  def self.average_price(type)
    ($producers.inject(0.0) { |memo, producer| moemo + producer.price[type]}/
      $producers.size).round(2)
  end

  def self.supply(type)
    $producers.inject(0) { |memo, producer| memo + producer.supply[type] }
  end

  def self.demands
    $consumers.inject(0) { |memo, consumer| memo + consumer.demands }
  end

  def self.cheaper(a,b)
    cheapest_a_price = $producers.min_by {|f| f.price[q]}.price[a]
    cheapest_b_price = $producers.min_by {|f| f.price[b]}.price[b]
    cheapest_a_price = cheapest_b_price ? a : b
  end

  def self.chepest_producer(type)
    producers = $producers.find_all {|producer| producer.supply[type] > 0}
    producers.min_by{|producer| producer.price[type]}
  end
end

