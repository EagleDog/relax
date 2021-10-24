# Encoding: UTF-8
#                                             #
#                ENDING                       #
#                                             #

class Ending < Chingu::GameState
  trait :timer
  def setup
    self.input = { :esc => :exit }
  end






  def draw
    Gosu::Image["assets/intro/background.png"].draw(0, 0, 0)    # Background Image: Raw Gosu Image.draw(x,y,zorder)-call
    super
  end
end
