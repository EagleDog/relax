# Encoding: UTF-8

class Human < Player
  def setup
    @image = Gosu::Image.new("assets/characters/knight.png")
    @shadow = Gosu::Image.new("assets/characters/char_shadow.png")
    @boom = Gosu::Sample.new("assets/audio/explosion.ogg")

    self.input = {  [:holding_left, :holding_a] => :go_left,
                    [:holding_right, :holding_d] => :go_right,
                    [:holding_up, :holding_w] => :go_up,
                    [:holding_down, :holding_s] => :go_down    }

    @x = @y = 300
    @vel_x = @vel_y = @angle = 0.0
    @score = 0
    @direction = 1
    @prev_x = 0
    @prev_y = 0
    @z = @y
  end
end