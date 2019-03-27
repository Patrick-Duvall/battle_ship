require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/computer"
require "./lib/computer"
require "stringio"
require 'o_stream_catcher'
require "pry"




describe Computer do

  before do
    @computer = Computer.new
    @subplayer = Ship.new("Submarine", 2)
    @cruiserplayer = Ship.new("Cruiser", 3)
    @subcpu = Ship.new("Submarine", 2)
    @cruisercpu = Ship.new("Cruiser", 3)
  end


  it "cpu_placement direction  outputs a valid coordinate " do
    25.times do
      expect(
      @computer.cpu_placement_direction('B2',  rand(4)) == 'B3' ||
      @computer.cpu_placement_direction('B2',  rand(4)) == 'B1' ||
      @computer.cpu_placement_direction('B2',  rand(4)) == 'A2' ||
      @computer.cpu_placement_direction('B2',  rand(4)) == 'C2')
    end
  end


  it "works with a different valid coordinate " do
    25.times do
      expect(
      @computer.cpu_placement_direction('D4',  rand(4)) == 'D5' ||
      @computer.cpu_placement_direction('D4',  rand(4)) == 'D3' ||
      @computer.cpu_placement_direction('D4',  rand(4)) == 'C4' ||
      @computer.cpu_placement_direction('D4',  rand(4)) == 'E4')
    end
  end

  it "places all ships for cpu correctly" do
    25.times do
    expect(@computer.determine_cpu_placement([@subcpu, @cruisercpu]).each{|placement|placement.valid_placement?})
  end
  end

  it "can place different ships" do
    25.times do
      #Placing  all 4 ships, just for testing
    expect(@computer.determine_cpu_placement([@subcpu, @cruisercpu,@subplayer,@cruiserplayer]).each{|placement|placement.valid_placement?})
  end
  end

end
