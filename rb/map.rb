# Encoding: UTF-8


class Map
  def initialize

  end


  # Solid at a given pixel position?
def solid?(x, y)
  y < 0 || @tiles[x / 50][y / 50]
end


def check_collisions(x, y)
  if y < 160 && x > 100 && x < 400 ||       #couch
  y > 600 && x > 150 && x < 350 ||       #tv_stand
  y < 120 && x > 520 && x < 780 ||       #kitchenette
  y < 270 && x > 680 && x < 780 ||
  y < 300 && y > 280 && x > 760 && x < 880 ||
  y < 300 && y > 280 && x > 980 ||
  y > 490 && x > 980                   #dresser
    true
  end
end

