# Encoding: UTF-8


class Star
  attr_reader :x, :y
  
  def initialize(animation)
    @animation = animation
    @color = Gosu::Color::BLACK.dup
    @color.red = rand(256 - 40) + 40
    @color.green = rand(256 - 40) + 40
    @color.blue = rand(256 - 40) + 40
    @x = rand(1050) + 25
    @y = rand(650) + 25
  end
  
  def draw
    img = @animation[Gosu.milliseconds / 100 % @animation.size]
    img.draw(@x - img.width / 2.0, @y - img.height / 2.0,
        Z::STARS, 1, 1, @color, :add)
  end
end


class ToyChest
  attr_reader :x, :y

  def initialize
    @image = Gosu::Image.new("assets/toy_chest.png")
    @x = 600
    @y = 500
  end

  def empty
    @image = Gosu::Image.new("assets/empty_chest.png")
  end

  def draw
    @image.draw(@x, @y, 3)
  end

end

