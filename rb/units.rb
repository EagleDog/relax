# Encoding: UTF-8


class Unit < Player
  attr_reader :score
#  traits :collision_detection, :bounding_box
  # trait :bounding_circle, :collision_detection #, :debug => true
  # traits :velocity, :collision_detection

  def setup
    char_num = 1 + rand(14)
    @char = Gosu::Image.new("assets/characters/char" + char_num.to_s + ".png")
    @boom = Gosu::Sample.new("assets/audio/explosion.ogg")
    @x = rand(1000) + 50
    @y = rand(600) + 50
    @z = @y
    @vel_x = @vel_y = @angle = 0.0
    @score = 0
    @direction = 1
    @rate = 10
    @steps = 0    # step counter
    @max_steps = 10
    @left = false
    @right = false
    @up = false
    @down = false
    # @directions = {left: false, right: false, up: false, down: false}
    @walking = false
  end

  def ai
    count_steps
    return if @walking == true
    if rand(@rate) == 2
      @walking = true
      case rand(8) + 1
      when 1; @left = true
      when 2; @right = true
      when 3; @up = true
      when 4; @down = true
      when 5; @left = true; @up = true
      when 6; @left = true; @down = true
      when 7; @right = true; @up = true
      when 8; @right = true; @down = true
      end
      @left = false if @x < 50
      @right = true if @x < 50
      @right = false if @x > 1050
      @left = true if @x > 1050
      @up = false if @y < 50
      @down = true if @y < 50
      @down = false if @y > 650
      @up = true if @y > 650

    end
  end

  def count_steps
    @steps += 1
    if @steps >= @max_steps
      @steps = 0
      @walking = false
      @left = false
      @right = false
      @up = false
      @down = false
      @max_steps = rand(10) + 1
    end
  end

  def new_spot
    if check_collisions(@x, @y) == true
      @x = 600 - rand(50)
      @y = 200 - rand(50)
    end
  end

  def move
    ai
    go_left if @left == true
    go_right if @right == true
    go_up if @up == true
    go_down if @down == true
    @x += @vel_x
    @y += @vel_y
    walls
    object_collision
    
    @vel_x *= 0.85
    @vel_y *= 0.85
  end

  def draw
    @char.draw_rot(@x, @y, @y - 5, 0, 0.5, 0.5, @direction * 0.75, 0.75)
  end

end
