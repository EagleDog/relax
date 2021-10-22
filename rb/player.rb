# Encoding: UTF-8


class Player < Chingu::GameObject
  attr_reader :score, :x, :y
  
  def initialize
    @image = Gosu::Image.new("assets/characters/knight.png")
    @boom = Gosu::Sample.new("assets/audio/explosion.ogg")
    @x = @y = 300
    @vel_x = @vel_y = @angle = 0.0
    @score = 0
    @direction = 1
    @prev_x = 0
    @prev_y = 0
  end

  def get_coordinates
    @prev_x = @x
    @prev_y = @y
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

  def walls
    if @x > 1050 then @x = 1050 end
    if @x < 50 then @x = 50 end
    if @y > 650 then @y = 650 end
    if @y < 50 then @y = 50 end
  end

  def object_collision  
    if check_collisions(@x, @y) == true
      @x = @prev_x
      @y = @prev_y
    end
  end

  def move
    @x += @vel_x
    @y += @vel_y
    walls
    object_collision

    @vel_x *= 0.85
    @vel_y *= 0.85
  end
  
  def draw
    @image.draw_rot(@x, @y, Z::PLAYER, 0, 0.5, 0.5, @direction, 1)
#draw_rot(x, y, z, angle, center_x = 0.5, center_y = 0.5, scale_x = 1, scale_y = 1)
#    @image.draw_rot(@x, @y, Z::PLAYER, @angle)
  end
  

  def collect_stars(stars, particles)
    stars.reject! do |star|
      if Gosu.distance(@x, @y, star.x, star.y) < 35
        @score += 10
        @boom.play if rand(4) == 1
        3.times {particles.push(Particle.new(@x, @y))}
        true
      else
        false
      end
    end
  end
end
