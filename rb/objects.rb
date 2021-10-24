# Encoding: UTF-8


class ToyChest < Chingu::GameObject
  attr_reader :x, :y
  trait :timer

  def setup
    @image = Gosu::Image.new("assets/toy_chest.png")
    @full_chest = true
    @x = 600
    @y = 530
    @particles = nil
  end

  def assign_particles(particles)
    @particles = particles
  end

  def empty
    @image = Gosu::Image.new("assets/empty_chest.png")
    @full_chest = false
  end

  def full
    @image = Gosu::Image.new("assets/toy_chest.png")
    @full_chest = true
  end

  def play_time
    #play sounds
  end

#   def toy_shower(particles)
#     during(150) {
#       if rand(3) == 1 
#         1.times {particles.push(Particle.create(:x => @x + 100, :y => @y + 50))}
#       end
#     }
#     after(200) { empty }
#     after(5000) { full }
#   end

  def collide_kids(units, particles)
    units.each do |unit|
      if Gosu.distance(@x + 100, @y + 50, unit.x, unit.y) < 40
        # toy_shower(particles) if @full_chest == true
        play_time
      end
    end
  end

  def draw
    @image.draw(@x, @y, @y)
  end

end





# class Star
#   attr_reader :x, :y
  
#   def initialize(animation)
#     @animation = animation
#     @color = Gosu::Color::BLACK.dup
#     @color.red = rand(256 - 40) + 40
#     @color.green = rand(256 - 40) + 40
#     @color.blue = rand(256 - 40) + 40
#     @x = rand(1050) + 25
#     @y = rand(650) + 25
#   end
  
#   def draw
#     img = @animation[Gosu.milliseconds / 100 % @animation.size]
#     img.draw(@x - img.width / 2.0, @y - img.height / 2.0,
#         Z::STARS, 1, 1, @color, :add)
#   end
# end