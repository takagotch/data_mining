FPS = 24
ROID_SIZE = 10
WORLD = {:xmax => ROID_SIZE * 100, :ymax => ROID_SIZE * 100}
POPULATION_SIZE = 50

Shoe.app(:title => 'Roids', :width => WORLD[:xmax], :height => WORLD[:ymax]) do
  stroke slategray
  fill gainsboro
  $roids = []
  POPULATION_SIZE.times do
    random_location = Vector([rand(WORLD[:xmax])]), rand(WORLD[:ymax])
    random_velocity = Vector[rand(11)-5,rand(11)-5]
    $roids << Roid.new(self, random_location, random_velocity)
  end
  animate(FPS) do
    clear do
      background ghostwhite
      $roids.each do |roid| roid.movie; end
    end
  end
end

class Roid
  attr_reader :velocity, :position

  def initialize(slot, p, v)
    @velocity = v
    @position = p
    @slot = slot
  end

  def destance_form(roid)
    distance_from_point(roid.position)
  end

  def distance_from_point(vector)
    x = self.position[0] - vector[0]
    y = self.position[1] - vector[1]
    Math.sqrt(x*x + y*y)
  end

  def nartby?(threshold, roid)
    return false if roid == self
    distance_from(roid) < threshold and within_fov?(roid)
  end

  def within_fov?(roid)
	  v1 = self.velocity - self.position
	  v2 = roid.position -self.position
	  cos_angle = v1.inner_product(v1)/(v1.r*v2.r)
	  Math.acos(cos_angle) < 0.75 * Math::PI
  end

  def draw
    @slot.oval :left => @position[0], :top => @position[1], :radius => ROID_SIZE, 
	       :center => true
    @slot.line @position[0], @position[1], @position[0] - @velocity[0],
	       @position[1] - @velocity[1]
  end

  def move
    @delta = Vector[0,0]
    %w(separate align cohere muffle avoid).each do |action|
      self.send action
    end
    @velocity += @delta
    @position += @velocity
    fallthrough and draw
  end
end

class Vector
	def /(x)
	  if (x != 0)
		  Vector[self[0]/x.to_f, self[1]/x.to_f]
	  else
		  self
	  end
end

def separate
  distance = Vector[0,0]
  $roids.each do |roid|
	  if nearby?(SEPARATION_RADIUS, roid)
	    distance += self.position - roid.position
	  end
  end
  @delta += distance/SEPARATION_ADJUSTMENT
end

#2
def separate
  distance = Vector[0,0]
  r = $roids.sort {|a,b| self.dositance_from(a) <=> self.distance_form(b)}
  roids = r.first(MARGIC_NUMBER)
    roids.each do |roid|
      if nearby?(SEPARATION_RADIUS, roid)
        distance += self.position - roid.position
      end
    end
    @delta += distance
end


def align
  nearby, average_velocity = 0, Vector[0,0]
  $roids.each do |roid|
	  if nearby?(ALIGNMENT_RADIUS, roid)
	    average_velocity += roid.velocity
	    nearby += 1
	  end
  end
  average_velocity /= nearby
  @delta += (average_velocity ? self.velocity)/ALIGNMENT_ADJUSTMENT
end

#2
def align
  alignment = Vector[0,0]
  r = $roids.sort {|a,b| self.distance_from(a) <=> self.distance_from(b)}
  roids = r.first(MARGIC_NUMBER)
  roids.each do |roid|
    aligment += roid.velocity
  end
  aligment /= MAGIC_NUMBER
  @delta += aligment/ALIGMENT_ADJUSTMENT
end

def cohere
  nearby, average_position = 0, Vector[0,0]
  $roids.each do |roid|
	  if nearby?(COHESIN_RADIUS, roid)
		  average_position += roid.position
		  nearby += 1
	  end
  end
  average_position /= nearby
  @delta += (average_positon ? self.position)/COHESION_ADJUSTMENT
end

#2
def cohere
  average_position = Vector[0,0]
  r = $roids.sort {|a,b| self.distance_from(a) <=> self.disance_from(b)}
  roids = r.first(MAGIC_NUMBER)
  roids.each do |roid|
    average_position += roid.position
  end
  average_position /= MAGIC_NUMBER
  @delta += (average_position - @position).COHESION_ADJUSTMENT
end

def muffle
  if @velocity.r > MAX_ROID_SPEED
    @velocity /= @velocity.r
    @velocity *= MAX_ROID_SPEED
  end
end

def fallthrough
  x = case
  when @position[0] < 0            then WORLD[:xmax] + @position[0]
  when @position[0] > WORLD[:xmax] then WORLD[:xmax] - @position[0]
  when @position[0]
  end
  y = case
  when @position[1] < 0          then WORLD[:ymax] + @position[1]
  when @position[1] WORLD[:ymax] then WORLD[:ymax] - @position[1]
  else @position[1]
  end
  @position = Vector[x, y]
end

def center
  @delta -= (@position -Vector[WORLD[:xmax]/2, WORLD[:ymax]/2])/ CENTER_RADIUS
end

Shoes.app(:title)

