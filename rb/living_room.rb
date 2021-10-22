# Encoding: UTF-8
#                                             #
#                Relax.                       #
#            You've earned it.                #
#                                             #
#                                             #


class LivingRoom < Chingu::GameState #(Gamestate rescue Gosu::Window)
  def initialize
    super
    #super 1100, 700 #640, 480
#    self.caption = "__ __ Relax __ __"

    self.input = { :p => Pause, :r => lambda{ current_game_state.setup } }


    @img_back = Gosu::Image.new("assets/world.png")

    @toy_chest = ToyChest.new

    @player = Player.new
    
    @chars = []
    30.times { @chars.push(Unit.new) }
    @chars.each { |char| char.new_spot }
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
    super
    @player.get_coordinates
    keypress

    @player.move
    @player.collect_stars(@stars, @particles)

    @chars.each { |char| char.get_coordinates
                         char.move
                         char.collect_stars(@stars, @particles) }

    @particles.each { |particle| particle.movement }
    destroy_particles(@particles)
    
    # if rand(30) < 15 and @stars.size < 80
    #   3.times { @stars.push(Star.new(@star_anim)) }
    # end
  end
  
  def draw
    super
    @img_back.draw(0, 0, Z::BACKGROUND)
    @toy_chest.draw

    @player.draw
    @chars.each { |char| char.draw }
    @stars.each { |star| star.draw }
    @particles.each { |particle| particle.draw }
    @font.draw_text("Score: #{@player.score}", 10, 10, Z::UI, 1.0, 1.0, Gosu::Color::YELLOW)

  end
  
  # def button_down(id)
  #   if id == Gosu::KB_ESCAPE
  #     close
  #   else
  #     super
  #   end
  # end
end

