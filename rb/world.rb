# Encoding: UTF-8
#                                             #
#                Relax.                       #
#            You've earned it.                #
#                                             #
#                                             #


class World < Chingu::Window
  def initialize
    super 1100, 700 #640, 480
    self.caption = "__ __ Relax __ __"

    @img_back = Gosu::Image.new("assets/world.png")

    @toy_chest = ToyChest.new

    @human = Human.new

    @chars = []
    30.times { @chars.push(Unit.new) }

    @star_anim = Gosu::Image::load_tiles("assets/star.png", 25, 25)
    @stars = []
    @particles = []

    @font = Gosu::Font.new(20)
  end

  def make_particles
    5.times {@particles.push(Particle.new(@human.x, @human.y)) }
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

    @human.move
    @human.collect_stars(@stars, @particles)

    @chars.each { |char| char.move
                         char.collect_stars(@stars, @particles) }

    @particles.each { |particle| particle.movement }
    destroy_particles(@particles)

    if rand(30) < 15 and @stars.size < 80
      3.times { @stars.push(Star.new(@star_anim)) }
    end
  end

  def draw
    @img_back.draw(0, 0, Z::BACKGROUND)
    @toy_chest.draw

    @human.draw
    @chars.each { |char| char.draw }
    @stars.each { |star| star.draw }
    @particles.each { |particle| particle.draw }
    @font.draw_text("Score: #{@human.score}", 10, 10, Z::UI, 1.0, 1.0, Gosu::Color::YELLOW)

  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end
end

