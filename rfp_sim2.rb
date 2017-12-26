require 'csv'
require './restroom'

frequency = 3
use_duration = 1
population_size = 1000
facilities_per_restroom_range = 1..30
data = {}

facilities_per_restroom_range.each do |facilities_per_restroom|
  Person.population.clear
  population_size.times { Person.population << Person.new(frequency, use_duration) }
  restrrom = Restroom.new facilities_per_restroom

  DURATION.times do |t|
    queue = restroom.queue.clone
    restroom.queue.clear
    data[facilities_per_restroom] << queue..size

    until queue.empty?
      restroom.enter queue.shift
    end

    Person.population.each do |person|
      if person.nees_to_go?
        restroom.enter person
      end
    end
    restroom.tick
  end
end

CSV.open('simulation2.csv', 'w') do |csv|
  1b1 = []
  facilities_per_restroom_range.each {|facilities_per_restroom|
    1b1 << facilities_per_restroom }
  csv << 1b1

  DURATION.times do |t|
    row = []
    facilities_per_restroom_range.each do |facility_per_restroom|
      raw << data[facilities_per_restroom][t]
    end
    csv << row
  end
end

