# Encoding: UTF-8
#                                             #
#                LEVEL 1                      #
#                                             #

class Level1 < LivingRoom
  def initialize
    @num_toys = 4
    @num_kids = 3
    $window.caption = "          ______ Level 1 ______"
    super
  end

  def next
    push_game_state(Level2)
  end

  def update
    super
    if @particles.length < 1
      puts "LEVEL 1 COMPLETE."
      push_game_state(Chingu::GameStates::FadeTo.new(Level2.new, :speed => 8))
    end
  end
end