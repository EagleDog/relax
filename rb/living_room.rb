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

    @num_toys = 15
    @num_kids = 4

    @img_back = Gosu::Image.new("assets/world.png")

    @particles = []
    @num_toys.times do
      pp = Particle.create(:x => rand(1100), :y => rand(700))
      while pp.has_collisions
        pp.x = rand(1100)
        pp.y = rand(700)
      end
      @particles.push(pp)
    end
    @toy_chest = ToyChest.create(:x => 600, :y => 530, :zorder => 530)
    @toy_chest.assign_particles(@particles)

    @human = Human.create(:x => 300, :y => 300, :zorder => Z::PLAYER)
    @human.assign_particles(@particles)
    @units = []
    @num_kids.times { @units.push(Unit.create) }
    @units.each { |unit| unit.new_spot }
#   @star_anim = Gosu::Image::load_tiles("assets/star.png", 25, 25)
#   @stars = []
#   @human.input = { :holding_space => make_particles }

    @font = Gosu::Font.new(20)

  end

  def setup
    @bumping = false
    after(100) {@bumping = true}

    @shaking = true                 # screen_shake cooldown
    after(1000) {@shaking = false}
  end



  def make_particles
    5.times { @particles.push(Particle.create(:x => @human.x, :y => @human.y)) } #new(@human.x, @human.y)) }
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

    @human.get_coordinates
    @human.move
#    @human.update
#    @human.collect_stars(@stars, @particles)

    @human.collect_toys(@particles)

    @units.each_with_index do |unit, index|
      unit.get_coordinates
      unit.move
      if @bumping == true
        unit.bump_others(@units, @particles) #, @human) }
      end
      unit.grab_toy(@particles, index)
    end

    @toy_chest.collide_kids(@units, @particles)

    @particles.each { |particle|
      particle.get_coordinates
      particle.movement
      if particle.held == -1
        particle.x = @human.x
        particle.y = @human.y
        particle.direction = @human.direction
      elsif particle.held >= 0
        unit = @units[particle.held]
        particle.x = unit.x
        particle.y = unit.y
        particle.direction = unit.direction
      end
    }

#    destroy_particles(@particles)

#    collision_check

    # if rand(30) < 15 and @stars.size < 80
    #   3.times { @stars.push(Star.new(@star_anim)) }
    # end
  end





  def draw
    super
    @img_back.draw(0, 0, Z::BACKGROUND)
    @toy_chest.draw

    @human.draw
    @units.each { |unit| unit.draw }
#    @stars.each { |star| star.draw }
    @particles.each { |particle| particle.draw }
    @font.draw_text("Score: #{@human.score}", 10, 10, Z::UI, 1.0, 1.0, Gosu::Color::YELLOW)

  end

  # def button_down(id)
  #   if id == Gosu::KB_ESCAPE
  #     close
  #   else
  #     super
  #   end
  # end
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

