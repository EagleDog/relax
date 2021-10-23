# Encoding: UTF-8
#                                             #
#                Relax.                       #
#            You've earned it.                #
#                                             #
#                                             #


class LivingRoom < Chingu::GameState
  trait :timer
  def initialize
    super
    #super 1100, 700 #640, 480
#    self.caption = "__ __ Relax __ __"

    self.input = { :p => Pause, :r => lambda{ current_game_state.setup } }


    @img_back = Gosu::Image.new("assets/world.png")

    @toy_chest = ToyChest.new

    @player = Player.create(:x => 300, :y => 300, :zorder => Z::PLAYER)
    @units = []
    30.times { @units.push(Unit.create) }
    @units.each { |unit| unit.new_spot }
   @star_anim = Gosu::Image::load_tiles("assets/star.png", 25, 25)
   @stars = []
#   @player.input = { :holding_space => make_particles }

    @particles = []
    @font = Gosu::Font.new(20)

  end

  def setup
    @shaking = true                 # screen_shake cooldown
    after(1000) {@shaking = false}
  end



  def make_particles
    5.times {@particles.push(Particle.new(@player.x, @player.y)) }
  end

  def destroy_particles(particles)
    particles.reject! do |particle|
      if particle.y > 1100
        true
      end
    end
  end

  def collision_check
    Player.each_collision(Unit) do |player, unit|    # Collide player with stars
      player.bounce
      unit.bounce
      screen_shake      # do screen_shake method (see below)
    end
  end

  def screen_shake        
    if @shaking == false   # if screen shake is cooled down
      game_objects.each do |object|  # move each object right, down, left, up, right, down, left, up
        object.x += 10
        after(30) {object.y += 10}   # 30 ms tick time delay between each movement
        after(60) {object.x -= 10}
        after(90) {object.y -= 10}
        after(120) {object.x += 10}
        after(150) {object.y += 10}
        after(180) {object.x -= 10}
        after(210) {object.y -= 10}
      end
      @shaking = true  # screen_shake won't occur again until this becomes false
      after(1000) {@shaking = false}  # after 1000 ms, screen can shake again
    end
  end


  
  def update
    super

    @player.get_coordinates
#    keypress
    @player.move
#    @player.update
#    @player.collect_stars(@stars, @particles)

    @units.each { |unit| unit.get_coordinates
                         unit.move }
#                         unit.update }
 #                        unit.collect_stars(@stars, @particles) }

    @particles.each { |particle| particle.movement }
    destroy_particles(@particles)

#    collision_check
    
    # if rand(30) < 15 and @stars.size < 80
    #   3.times { @stars.push(Star.new(@star_anim)) }
    # end
  end





  def draw
    super
    @img_back.draw(0, 0, Z::BACKGROUND)
    @toy_chest.draw

    @player.draw
    @units.each { |unit| unit.draw }
#    @stars.each { |star| star.draw }
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

