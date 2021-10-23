# Encoding: UTF-8

# global methods


# Solid at a given pixel position?
def solid?(x, y)
  y < 0 || @tiles[x / 50][y / 50]
end


def check_collisions(x, y)
  if  y < 165 && x > 90 && x < 430 ||        #couch
      y < 130 && x > 510 && x < 800 ||       #kitchenette
      y < 280 && x > 660 && x < 800 ||
      y < 320 && y > 260 && x > 750 && x < 890 || #mini-wall
      y < 320 && y > 260 && x > 960 ||            #mini-wall
      y > 460 && x > 945            ||         #dresser
      y > 555 && x > 130 && x < 370        #tv_stand
        true
  end
end






class Map
  def initialize

  end
end

