require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/game"
require "stringio"
require 'o_stream_catcher'
require "pry"



describe Game do

  before do
    @game = Game.new
    @subplayer = Ship.new("Submarine", 2)
    @cruiserplayer = Ship.new("Cruiser", 3)
    @subcpu = Ship.new("Submarine", 2)
    @cruisercpu = Ship.new("Cruiser", 3)
  end


  it "cpu_placement direction  outputs a valid coordinate " do
    25.times do
      binding.pry
      expect(

      @game.cpu_placement_direction('B2',  rand(4)) == 'B3' ||
      @game.cpu_placement_direction('B2',  rand(4)) == 'B1' ||
      @game.cpu_placement_direction('B2',  rand(4)) == 'A2' ||
      @game.cpu_placement_direction('B2',  rand(4)) == 'C2')
    end
  end


  it "works with a different valid coordinate " do
    25.times do
      expect(
      @game.cpu_placement_direction('D4',  rand(4)) == 'D5' ||
      @game.cpu_placement_direction('D4',  rand(4)) == 'D3' ||
      @game.cpu_placement_direction('D4',  rand(4)) == 'C4' ||
      @game.cpu_placement_direction('D4',  rand(4)) == 'E4')
    end
  end

  it "places all ships for cpu correctly" do
    25.times do
    expect(@game.determine_cpu_placement([@subcpu, @cruisercpu]).each{|placement|placement.valid_placement?})
    expect(@game.determine_cpu_placement([@subcpu, @cruisercpu]).length).to eq 2
  end
  end

  it "can place different ships" do
    25.times do
      #Placing  all 4 ships, just for testing
    expect(@game.determine_cpu_placement([@subcpu, @cruisercpu,@subplayer,@cruiserplayer]).each{|placement|placement.valid_placement?})
  end
  end

  # it "chooses a proper game based on prompt" do
  #
  #   string_io = StringIO.new #New instance of StringIO
  #   string_io.puts "c"       #Stub user input of 0
  #   string_io.rewind
  #           #Start form first stub
  #   $stdin = string_io
  #
  #   # result, stdout, stderr = OStreamCatcher.catch do
  #   #   @game.choose_game_prompt
  #   # end
  #
  #     #Override Ruby's standard input
  #   expect("custom").to eq(@game.choose_game_prompt)
  #
  #   # player.turn!(board)      #Call method
  #   $stdin = STDIN           #Reset Ruby's standard input
  #
  #
  # end


end

  # it "places ships for cpu correctly" do


  # it "exits on q" do
  #   expect(Game).to_recieve(:welcome).with('q')
  # end
