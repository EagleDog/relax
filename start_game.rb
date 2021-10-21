# Encoding: UTF-8
#                                             #
#                Relax.                       #
#            You've earned it.                #
#                                             #
#                                             #


require "gosu"
require_relative "rb/world"
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


World.new.show if __FILE__ == $0
