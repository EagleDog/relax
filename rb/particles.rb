# Encoding: UTF-8


class Particle
  attr_reader :x, :y
  
  def initialize(x, y)
    @image = Gosu::Image.new("assets/particles/particle1.png")
    @x = x
    @y = y
    @vel_y = rand(10) -15 # Vertical velocity
    @vel_x = rand(20) - 10
  end

  def movement
    @vel_y += 0.5
    @y = @y + @vel_y

    @x += @vel_x


    # after(1550) {self.destroy}
  end

  def draw
    @image.draw(@x, @y, 5)
  end
end
