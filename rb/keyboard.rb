# Encoding: UTF-8


def keypress
  if Gosu.button_down? Gosu::KB_LEFT or Gosu.button_down? Gosu::KB_A
    @player.go_left
  end
  if Gosu.button_down? Gosu::KB_RIGHT or Gosu.button_down? Gosu::KB_D
    @player.go_right
  end
  if Gosu.button_down? Gosu::KB_UP or Gosu.button_down? Gosu::KB_W
    @player.go_up
  end
  if Gosu.button_down? Gosu::KB_DOWN or Gosu.button_down? Gosu::KB_S
    @player.go_down
  end
  if Gosu.button_down? Gosu::KB_SPACE
    make_particles
  end

end


