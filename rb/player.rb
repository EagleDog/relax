# Encoding: UTF-8


class Player
  attr_reader :score, :x, :y
  
  def initialize
    @image = Gosu::Image.new("assets/knight.png")
    @boom = Gosu::Sample.new("assets/audio/explosion.ogg")
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
    @direction = 1
  end
  
  def warp(x, y)
    @x, @y = x, y
  end
  
  def go_left
    @vel_x -= 1
    @x -= 5
    @direction = -1
  end
  
  def go_right
    @vel_x += 1
    @x += 5
    @direction = 1
  end
  
  def go_up
    @vel_y -= 1
    @y -= 5
  end

  def go_down
    @vel_y += 1
    @y += 5
  end

  def is_hall
    if @y > 300 and @y < 500
      true
    else
      false
    end
  end

  def walls
    if @x > 1080
      @x = 1080
#      is_hall ? @x = -40 : @x = 1110
    end
    if @x < 20
      @x = 20
#      is_hall ? @x = 1140 : @x = -10
    end
    if @y > 680
      @y = 680
    end
    if @y < 20
      @y = 20
    end
  end
  
  def move
    @x += @vel_x
    @y += @vel_y
    walls
#    @x %= 1140
    @y %= 740
    
    @vel_x *= 0.8
    @vel_y *= 0.8
  end
  
  def draw
    @image.draw_rot(@x, @y, ZOrder::PLAYER, 0, 0.5, 0.5, @direction, 1)
#draw_rot(x, y, z, angle, center_x = 0.5, center_y = 0.5, scale_x = 1, scale_y = 1)
#    @image.draw_rot(@x, @y, ZOrder::PLAYER, @angle)
  end
  

  def collect_stars(stars, particles)
    stars.reject! do |star|
      if Gosu.distance(@x, @y, star.x, star.y) < 35
        @score += 10
        @boom.play
        5.times {particles.push(Particle.new(@x, @y))}
        true
      else
        false
      end
    end
  end
end
