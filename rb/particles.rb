# Encoding: UTF-8


class Particle < Chingu::GameObject
  attr_reader :x, :y, :held
  attr_writer :x, :y, :vel_x, :vel_y, :moving, :held, :direction
  trait :timer
#  trait :bounding_circle, :debug # => true
#  traits :velocity, :collision_detection
  
  def setup #initialize(x, y)
    part_num = rand(30) + 1
    particle = "obj" + part_num.to_s
    @image = Gosu::Image.new("assets/particles/" + particle + ".png")
    @color = Gosu::Color::BLACK.dup
    @color.red = rand(256 - 100) + 80
    @color.green = rand(256 - 100) + 80
    @color.blue = rand(256 - 100) + 80
    @color.alpha = 255
    @x = x
    @y = y
    @vel_y = 0
    @vel_x = 0
    @prev_x = x
    @prev_y = y
    @air = 300
    @ground = rand(200) + 200

    @held = -2
    @direction = 1.0
    @offset_x = rand(11) / 10
    @offset_y = rand(11) / 10

    # # Code for initial movement:
    # @vel_y = rand(10) - 20 # Vertical velocity
    # @vel_x = rand(20) - 10
    # @moving = true
    # stop_moving
  end

  # def setup
  #   after(400) {stop_moving}
  # end

  def get_coordinates
    @prev_x = @x
    @prev_y = @y
  end

  def has_collisions
    return true if check_collisions(@x, @y) == true
    return true if @x > 1040
    return true if @x < 50
    return true if @y > 610
    return true if @y < 70
    return false
  end

  def collision_x
    @x = @prev_x if check_collisions(@x, @y) == true
  end

  def collision_y
    @y = @prev_y if check_collisions(@x, @y) == true
  end

  def walls
    if @x > 1040 then @x = 1040; @vel_x = -@vel_x end
    if @x < 50 then @x = 50; @vel_x = -@vel_x end
    if @y > 610 then @y = 610; @vel_y = -@vel_y end
    if @y < 70 then @y = 70; @vel_y = -@vel_y end
  end

  def stop_moving
    air_time = rand(900) + 300
    after(air_time) { @moving = false }
  end

  def movement
    if @moving == true
      @vel_y += 0.5
      @y = @y + @vel_y
      collision_y

      @x += @vel_x
      collision_x
      walls
#      stop_moving if @y > @ground && @y < @air
    end
  end

  def update

  end

  def draw
    @image.draw_rot(@x, @y, @y + 10, 0, @offset_x, @offset_y, @direction, 1.0, @color)
  end
end
