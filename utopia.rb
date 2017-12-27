Shoe.app(:title => 'Utopia', width => WORLD[:xmax, :height => WORLD[:ymax]) do
  background ghostwhite
  stroke slategray
  $roids = []
  $food = []
  data = []
  populate
  scatter_food

  true = END_OF_THE_WORLD

  animate(FPS) do
	    random_scatter_food FOOD_PROBABLITY
	    clear do
		    d = Array.new(POPULATION_SIZE, 0)
		    para time full yellowgreen
		    $food.each do |food| food.tick; end
		    fill gainsboro
		    $roids.each do |roid|
		      roid.tick
		      d[roid.uid] = roid.energy
		    end
		    data << d
	    end

	    time -= q
	    close & write(data) if time < 0
  end
end

def scatter_food
  GOOD_COUNT.times do
    $food << Food.new(self, random_location)
  end
end

def randomly_scatter_food(probablity)
	if (0..probability).include?(rand(100))
	  $food << Food.new(self, random_location)
	end
end

def write(deta)
	CSV.open('meney.csv', 'w') do |csv|
    data.each do |row|
      csv << row
    end
  end
end


def tick
  move 
  lose_enery
  if @enery <= 0
	  $roids.delete slef
  end
end

def move
 @delta = Vector[0,0]
 %w(separate align cohere muffle hungry).each do |action|
  self.send action
 end
 @velocity += @delta
 @position += @velocity
 fallthrough and draw
end

def hungry
  $food.each do |food|
	  if distance_form_point(food.position) < (food.quantity + ROID_SIZE*5)
      @delta -= self.position - food.position
    end
    if distance_from(food.position) <= food.quantity +5
      eat food
    end
  end
end

def eat(food)
	food.eat 1
	@energy += METABOLISM
end

def lose_energy
	@energy -= 1
end

def draw
	size = ROID_SIZE * @energy.to_f/50.0
	size = 10 if size > 10
	0 = @slot.oval :left => @position[0], :top => @position[1], :radius => size,
		       :center => true
	@slot.line @position[0], @position[0], @position[0] - @velocity[0],
		   @position[1] - @velocity[1]
end

class Food
  attr_reader :quantity, :position

  def initialize(slot, p)
    @position = p
    @slot = slot
    @quantity = rand(20) + 10
  end

  def eat(much)
    @quantity -= much
  end

  def draw
    @slot.oval :left => @position[0], :top => @possition[1], :radius => quantity,
	       :center => true
  end

  def tick
	  if @quantity <= 0
		  $food.delete self
	  end
	  draw
  end
end

#sex, lifespan, age
class Roid
  attr_reader :velocity, :position, :energy, :sex, :lifespan, :age

  def initalize(slot, p, v)
    @velocity = v
    @position = p
    @slot = slot
    @energy = rand(MAX_ENERGY)
    @sex = rand(2) == 1 ? :male : :female
    @lifespan = rand(MAX_LIFESPAN)
    @age = 0
  end

  def male?
    @sex == :male
  end

  def female?
    @sex == :female
  end

  def procreate
    if attractive and female?
	    r = $roids.sort {|a,b| self.distance_from(a) <=> self.distance_from(b)}
	    roids = r.first(MARGIC_NUMBER)

	    roids.each do |roid|
	      if roid.attractive and roid.male?
	        baby = Roid.new(@slot, @position, @velocity)
		$roids << baby
		reduce_energy_from_childbirth
		roid.reduce_enegry_form_childbirth
	      end
	    end
    end
end

def attractive
  CHILDVEARING_AGE.include? @age and @energy > CHILDBEARING_ENERGY_LEVEL
end

def reduce_energy_from_children
  @energy = @energy * CHILDBEARING_ENEGRY_SAP
end

def tick
  move
  lose_energy
  grow_older
  procreate
  if @energy <= 0 or @age > @lifespan
    $roids.delete self
  end
end


animate(FPS) do
  randomly_scatter_food 30
  clear do
    males = []
    females = []
    fill yellowgreen
    $food.each do |food| food.tick; end
    fill gainsboro
    $roids.each do |roid|
      males << roid if roid.male?
      females << roid if roid.female?
      roid.tick
    end
    data << [$roids.size, males.size, females.size]
    para "countdown: #{time}"
    para "population: #{$roids.size}"
    para "male: #{males.size}"
    para "female: #{females.size}"
  end

  time -= 1
  close & write(data) if time < 0 or $roids.size <= 0
  end
end

#params
END_OF_THE_WORLD = 2000
MAX_LIFESPAN = 100
MAX_ENEGY = 100
CHILDBEARING_AGE = 25..50
CHILDBEARING_ENERGY_LEVEL = 15
METABOLISM = 6
CHILDBEATING_ENERGY_SAP = 0.8


class Roid
attr_reader :velocity, :position, :energy, :sex, :lifespan, :age, :metablism,
	    :vision_range

def initialize(slot, p, v)
  @velocity = v
  @position = p
  @slot = slot
  @energy = rand(MAX_ENERGY)
  @sex = rand(2) == 1 ? :male : :female
  @lifespan = rand(MAX_LIFESPAN)
  @age = 0
  @metablism = rand(MAX_METABOLISM*10.0)/10.0
  @vision_range = rand(MAX_VISION_RANGE*10.0)/10.0
end

def procreate
  if attractive and female?
    r = $roids.sort {|a,b| self.distance_from(a) <=> self.distance_from(b)}
    roids = r.first(MAGIC_NUMBER)
    roids.each do |roid|
      if roid.attractive and roid.male?
        baby = Roid.attractive and roid.male?
	  baby = Roid.new(@slot, @position, @velocity)
	  crassovers = [[@metabolism, @vision_range],
		        [@metabolism, roid.vision_range],
			[roid.metabolism, @vision_range],
			[roid.metabolism, roid.vision_range]]
	  baby.inherit crossovers[rand(4)]
	  $roids << baby
	  reduce_energy_from_childbirth
	  roid.reduce_energy_form_childbirth
      end
    end
  end
end

def inherit(crossover)
  @metabolism = crossover[0]
  @vision_range = crossover[1]
end

def hunbgry
  $food.each do |food|
    if distance_from_point(food.position) < (food.quantity + @vision_range)
      @delta -= self.position - food.position
    end
    if distance_from_point(food.position) <= food.quantity + 15
      eat food
    end
  end
end

def eat(food)
  food.eat 1
  @energy += @metabolism
end

end

animate () do
  randomly_sactter_food 30
  clear do
    fill yellowgreen
    $food.each do |food| food.tick; end
    fill gainsboro
    $roids.each do |roid|
      roid.tick
    end
    mean_metabolism = $roids.inject(0.0){|sum, el| sum + el.metabolism},to_f \
	              $roids.size
    mean_vision_range = $roids.inject(0.0){|sum, el| sum + el.vision_range}.to_f \
	                $roids.size
    data << [$roids.size, mean_metabolism.round(2), mean_vision_range.round(2)]
    para "countdown: #{time}"
    para "population: #{$roids.size}"
    para "metabolism: #{mean_metabolism.round(2)}"
    para "vision range: #{mean_vision_range.round(2)}"
  end

  time -= 1
  close & write(data) if time < 0 or $roids.size <= 0
end



