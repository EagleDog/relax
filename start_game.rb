# Encoding: UTF-8
#                                             #
#                Relax.                       #
#            You've earned it.                #
#                                             #
#                                             #

require_relative 'chingu/chingu'
# require "gosu"
require_relative "rb/intro_objects.rb"
require_relative "rb/beginning.rb"
require_relative "rb/living_room.rb"
require_relative "rb/keyboard"
require_relative "rb/player"
require_relative "rb/units"
require_relative "rb/objects"
require_relative "rb/map"
require_relative "rb/particles"
#require_relative "rb/gamestate"


module Z
  BACKGROUND, STARS, UNIT, PLAYER, UI = *0..4
end

module Zorder  # define some frequently used Zorders
  GUI = 400
  Text = 300
  Main_Character = 200
  Main_Character_Particles = 199
  Object = 50
  Projectile = 15
  Particle = 5
end

module Colors   # define some colors
  Dark_Orange = Gosu::Color.new(0xFFCC3300)
  White = Gosu::Color.new(0xFFFFFFFF)
  Blue_Laser = Gosu::Color.new(0xFF86EFFF)
end

class Game < Chingu::Window
  def initialize
    super(1100,700,false) #640, 480
    self.caption = "          ______ Relax ______"
    self.input = { :esc => :exit,  # global controls
#                   :p => Pause,
#                 [:q, :l] => :pop,
#                 :z => :log,
#                 :r => lambda{current_game_state.setup}
                  :space => :begin
               }
#    retrofy
  end

 def setup
   push_game_state(Beginning)
 end

 def begin
   push_game_state(LivingRoom)
 end

end

Game.new.show # if __FILE__ == $0