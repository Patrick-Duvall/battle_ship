require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/game"
require "pry"

describe Game do

  before do
    @game = Game.new
    @subplayer = Ship.new("Submarine", 2)
    @cruiserplayer = Ship.new("Cruiser", 3)
    @subcpu = Ship.new("Submarine", 2)
    @cruisercpu = Ship.new("Cruiser", 3)
  end

  it "has a welcome method" do
    skip
    expect(@game.welcome).to eq("Welcome to BATTLESHIP \n Enter p to play. Enter q to quit.")
  end

  it "cpu_placement direction  outputs a valid coordinate " do
    25.times do
      expect(
      @game.cpu_placement_direction('B2', @game.cpu_board.size) == 'B3' ||
      @game.cpu_placement_direction('B2', @game.cpu_board.size) == 'B1' ||
      @game.cpu_placement_direction('B2', @game.cpu_board.size) == 'A2' ||
      @game.cpu_placement_direction('B2', @game.cpu_board.size) == 'C2')
    end
  end

  it "places all ships for cpu correctly" do
    skip
    expect(@game.determine_cpu_placement.each{|placement|placement.valid_placement?})
  end
end

  # it "places ships for cpu correctly" do


  # it "exits on q" do
  #   expect(Game).to_recieve(:welcome).with('q')
  # end
