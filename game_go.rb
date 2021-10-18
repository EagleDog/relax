# Encoding: UTF-8
#                                             #
#                Relax.                       #
#            You've earned it.                #
#                                             #
#                                             #


require "gosu"
require_relative "rb/keyboard"
require_relative "rb/player"
require_relative "rb/units"
#require_relative "rb/gamestate"
require_relative "rb/particles"

module ZOrder
  BACKGROUND, STARS, PLAYER, UI = *0..3
end


class Star
  attr_reader :x, :y
  
  def initialize(animation)
    @animation = animation
    @color = Gosu::Color::BLACK.dup
    @color.red = rand(256 - 40) + 40
    @color.green = rand(256 - 40) + 40
    @color.blue = rand(256 - 40) + 40
    @x = rand * 640
    @y = rand * 480
  end
  
  def draw
    img = @animation[Gosu.milliseconds / 100 % @animation.size]
    img.draw(@x - img.width / 2.0, @y - img.height / 2.0,
        ZOrder::STARS, 1, 1, @color, :add)
  end
end


class World < (Gamestate rescue Gosu::Window)
  def initialize
    super 1100, 700 #640, 480
    self.caption = "__ __ Relax __ __"
    
    @background_image = Gosu::Image.new("assets/living_room.png", tileable: true)
    
    @player = Player.new
    @player.warp(320, 240)
    
    @star_anim = Gosu::Image::load_tiles("assets/star.png", 25, 25)
    @stars = []
    @particles = []

    @font = Gosu::Font.new(20)
    make_particles
  end

  def make_particles
    5.times {@particles.push(Particle.new(@player.x, @player.y)) }
    @particles.each.reject
  end
  
  def update
    keypress

    @player.move
    @player.collect_stars(@stars, @particles)

    @particles.each { |particle| particle.movement }
    
    if rand(100) < 4 and @stars.size < 25
      @stars.push(Star.new(@star_anim))
    end
  end
  
  def draw
    @background_image.draw(0, 0, ZOrder::BACKGROUND)
    @player.draw
    @stars.each { |star| star.draw }
    @particles.each { |particle| particle.draw }
    @font.draw_text("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
  end
  
  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end
end

World.new.show if __FILE__ == $0
