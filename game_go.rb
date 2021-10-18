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
require_relative "rb/objects"
#require_relative "rb/gamestate"
require_relative "rb/particles"

module Z
  BACKGROUND, STARS, UNIT, PLAYER, UI = *0..4
end


class World < (Gamestate rescue Gosu::Window)
  def initialize
    super 1100, 700 #640, 480
    self.caption = "__ __ Relax __ __"

    @background_image = Gosu::Image.new("assets/living_room.png", tileable: true)
    @player = Player.new
    
    @chars = []
    30.times { @chars.push(Unit.new) }
    # @char1 = Unit.new

    # @char1.warp(rand(1000) - 100, rand(700) - 100)

    @star_anim = Gosu::Image::load_tiles("assets/star.png", 25, 25)
    @stars = []
    @particles = []

    @font = Gosu::Font.new(20)
  end

  def make_particles
    5.times {@particles.push(Particle.new(@player.x, @player.y)) }
    @particles.each.reject
  end

  def destroy_particles(particles)
    particles.reject! do |particle|
      if particle.y > 1100
        true
      end
    end
  end
  
  def update
    keypress

    @player.move
    @player.collect_stars(@stars, @particles)

    @chars.each { |char| char.move
                         char.collect_stars(@stars, @particles) }

    @particles.each { |particle| particle.movement }
    destroy_particles(@particles)
    
    if rand(30) < 15 and @stars.size < 80
      3.times { @stars.push(Star.new(@star_anim)) }
    end
  end
  
  def draw
    @background_image.draw(0, 0, Z::BACKGROUND)
    @player.draw
    @chars.each { |char| char.draw }
    @stars.each { |star| star.draw }
    @particles.each { |particle| particle.draw }
    @font.draw_text("Score: #{@player.score}", 10, 10, Z::UI, 1.0, 1.0, Gosu::Color::YELLOW)
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
