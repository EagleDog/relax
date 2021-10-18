# Encoding: UTF-8


class Unit < Player
  attr_reader :score
  
  def initialize
    @char1 = Gosu::Image.new("assets/characters/char1.png")
    @char2 = Gosu::Image.new("assets/characters/char2.png")
    @char3 = Gosu::Image.new("assets/characters/char3.png")
    @char4 = Gosu::Image.new("assets/characters/char4.png")


    @boom = Gosu::Sample.new("assets/audio/explosion.ogg")
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
    @direction = 1
  end
  
  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480
    
    @vel_x *= 0.95
    @vel_y *= 0.95
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
