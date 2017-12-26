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
    v1 =
    v2 =
    cos_angle = v1.
    Math.acros() < 0.75 * Math::PI
  end

  def draw
    @slot.oval :left => @position[], :top => @position[], :radius => ROID_SIZE, 
	       :center => true
    @slot.line @position[], @position[], @position[] - @celocity[],
	       @position[] - @velocity[]
  end

  def move
    @delta = Vector[]
    %w().each do |action|
      self.send action
    end
    @velocity += @delta
    @position += @velocity
    fallthrough and draw
  end
end


