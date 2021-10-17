# Encoding: UTF-8
#                                             #
#                Relax.                       #
#            You've earned it.                #
#                                             #
#                                             #

require 'gosu'

require_relative 'rb/beginning.rb'   # require relevant files
# require_relative 'rb/levels.rb'
# require_relative 'rb/objects.rb'
# require_relative 'rb/gui.rb'
# require_relative 'rb/ending.rb'
require_relative 'rb/characters.rb'

module Zorder  # define Zorders
	GUI = 400
	Text = 300
	Main_Character = 200
	Main_Character_Particles = 199
	Object = 50
	Projectile = 15
	Particle = 5
end

module Colors   # define colors
	Dark_Orange = Gosu::Color.new(0xFFCC3300)
	White = Gosu::Color.new(0xFFFFFFFF)
	Blue_Laser = Gosu::Color.new(0xFF86EFFF)
end

#
#  GameWindow Class
#
class GameWindow < (Example rescue Gosu::Window) # < Chingu::Window
  def initialize
    super(800,600,false)
    $intro = true     # define constants used in game
    $max_x = 815
    $max_y = 615
    $scr_edge = 15
    $cooling_down = 70
    $star_grab = "media/audio/star_pickup.ogg" #Sound["media/audio/star_pickup.ogg"]
    $power_up = "media/audio/power_up.ogg" #Sound["media/audio/power_up.ogg"]
    self.caption = " __ __ Chingu Gem Go __ __ "
    @cursor = true                        # false hides cursor

##==========>>>>>
##__________>>>>>

    self.input = { :esc => :exit,         # global controls
                 [:q, :l] => :pop,
                 :z => :log,
                 :r => lambda{current_game_state.setup}
               }


#    retrofy   # use retrofy for improved scaling of images
  end

  def setup
    push_game_state(Beginning) # start by pushing Beginning gamestate
  end

  def log   # pressing 'z' at any time returns name of current gamestate
    puts $window.current_game_state
  end

  def pop  # pressing 'q' or 'l' at any time backs out of current gamestate
    if $window.current_game_state.to_s == "Introduction" or $window.current_game_state.to_s == "Level_1" then
      pop_game_state(:setup => true)
    elsif $window.current_game_state.to_s != "OpeningCredits"
      pop_game_state(:setup => false)
    end
  end
end


GameWindow.new.show if __FILE__ == $0   #Game.new.show alternate window class