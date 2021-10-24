# Encoding: UTF-8
#                                             #
#                LEVEL 3                      #
#                                             #

class Level3 < LivingRoom
  def initialize
    @num_toys = 35
    @num_kids = 14
    super
  end

  def update
    super
    if @particles.length < 1
      puts "YOU'VE WON!"
      push_game_state(Chingu::GameStates::FadeTo.new(Level3.new, :speed => 8))
    end
  end
end