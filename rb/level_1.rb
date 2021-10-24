# Encoding: UTF-8
#                                             #
#                LEVEL 1                      #
#                                             #

class Level1 < LivingRoom
  def initialize
    @num_toys = 2
    @num_kids = 2
    super
  end

  def update
    super
    if @particles.length < 1
      puts "YOU'VE WON!"
      push_game_state(Chingu::GameStates::FadeTo.new(Level2.new, :speed => 8))
    end
  end
end