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


