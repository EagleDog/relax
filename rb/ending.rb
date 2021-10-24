# Encoding: UTF-8
#                                             #
#                ENDING                       #
#                                             #

class Ending < Chingu::GameState
  trait :timer
  def setup
    Chingu::Text.destroy_all # destroy any previously existing Text, Player, EndPlayer, and Meteors
    Player.destroy_all
    self.input = { :esc => :exit, [:enter, :return] => :next }

    $music = Gosu::Song["assets/audio/intro_song.ogg"]
    $music.volume = 0.8
    $music.play(true)

    after(300) {
      @text = Chingu::Text.create("The End", :y => 150, :font => "GeosansLight", :size => 45, :color => Colors::Dark_Orange, :zorder => Z::GUI)
      @text.x = 1100/2 - @text.width/2 # center text
      after(300) {
        @text2 = Chingu::Text.create("Press ENTER to continue.", :y => 510, :font => "GeosansLight", :size => 45, :color => Colors::Dark_Orange, :zorder => Z::GUI)
        @text2.x = 1100/2 - @text2.width/2 # center text
        after(300) {
#          @player = EndKnight.create(:x => 400, :y => 450, :zorder => Z::Main_Character)
        }
      }
    }

  end


  def next
    push_game_state(Introduction)
  end



  def draw
    Gosu::Image["assets/intro/background.png"].draw(0, 0, 0)    # Background Image: Raw Gosu Image.draw(x,y,zorder)-call
    super
  end
end
