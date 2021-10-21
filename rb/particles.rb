# Encoding: UTF-8


class Particle
  attr_reader :x, :y
  
  def initialize(x, y)
    part_num = rand(30) + 1
    particle = "obj" + part_num.to_s
    @image = Gosu::Image.new("assets/particles/" + particle + ".png")
    @color = Gosu::Color::BLACK.dup
    @color.red = rand(256 - 100) + 40
    @color.green = rand(256 - 100) + 40
    @color.blue = rand(256 - 100) + 40
    @color.alpha = 255
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
    @image.draw(@x, @y, 5, 2, 2, @color, :add) #, @color, :add)
  end
end
