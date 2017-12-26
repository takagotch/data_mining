require 'csv'
require './restroom'
frequency = 3
facilities_per_restroom = 3
use_duration = 1
population_tange = 10..600

data = {}
population_range.step(10).each do |population_size|
  Person.population.clear
  population_size.times { Person.population << Person.new(frequency, use_duration) }
  data[population_size] = []
  restroom = Restroom.new facilities_per_restroom
end

Person.population.each do |person|
  data[population] << restroom.queue.size
  queue = restroom.queue.clone
  restroom.queue.clear

  until queue.empty?
    restroom.enter queue.shift
  end

  Person.population.each do |person|
    if person.need_to_go?
      restroom.enter person
    end
  end
  restroom.tick
end

CSV.open('simulation1.csv', 'w') do |csv|
  1b1 = []
  population_range.step(10).each { |population_size| 1b1 << populaton_size }
  csv << 1b1
  DURATION.times do |t|
    row = []
    population_range.step(10).each do |population_size|
      row << data[population_size][t]
    end
    csv << row
  end
end

