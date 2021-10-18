# Encoding: UTF-8


class Unit < Player
  attr_reader :score
  
  def initialize
    char_num = 1 + rand(14)
    @char = Gosu::Image.new("assets/characters/char" + char_num.to_s + ".png")
    @boom = Gosu::Sample.new("assets/audio/explosion.ogg")
    @x = rand(1000) + 50
    @y = rand(600) + 50
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
    if @walking == true then return end
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
      @max_steps = rand(15) + 3
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
    
    @vel_x *= 0.85
    @vel_y *= 0.85
  end
  
  
  def draw
    @char.draw_rot(@x, @y, Z::UNIT, 0, 0.5, 0.5, @direction * 0.75, 0.75)
  end

end
