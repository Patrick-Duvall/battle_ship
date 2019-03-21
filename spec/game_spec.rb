require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/game"

describe Game do

  before do
    @game = Game.new
    @subplayer = Ship.new("Submarine", 2)
    @cruiserplayer = Ship.new("Cruiser", 3)
    @subcpu = Ship.new("Submarine", 2)
    @cruisercpu = Ship.new("Cruiser", 3)
  end

  it "has a welcome method" do
    expect(@game.welcome).to eq("Welcome to BATTLESHIP \n Enter p to play. Enter q to quit.")
  end

end
