require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/game"
require "./lib/cpu"

describe Game do

  before do
    @game = Game.new
    @subplayer = Ship.new("Submarine", 2)
    @cruiserplayer = Ship.new("Cruiser", 3)
    @subcpu = Ship.new("Submarine", 2)
    @cruisercpu = Ship.new("Cruiser", 3)
    @playerboard = Board.new
    @cpuboard = Board.new
    @cpuboard.cell_gen(4)
    @cpu = CPU.new(@cpuboard, @playerboard)
  end

  it "cpu_placement direction  outputs a valid coordinate " do
    # 25.times do
      expect(
      @cpu.cpu_placement_direction('B2') == 'B3' ||
      @cpu.cpu_placement_direction('B2') == 'B1' ||
      @cpu.cpu_placement_direction('B2') == 'A2' ||
      @cpu.cpu_placement_direction('B2') == 'C2')
    # end
  end


  it "works with a different valid coordinate " do
    # 25.times do
      expect(
      @cpu.cpu_placement_direction('D4') == 'D5' ||
      @cpu.cpu_placement_direction('D4') == 'D3' ||
      @cpu.cpu_placement_direction('D4') == 'C4' ||
      @cpu.cpu_placement_direction('D4') == 'E4')
    # end
  end

  it "places all ships for cpu correctly" do
    # 25.times do
      ships = []
      @cpu.determine_cpu_placement([@subcpu, @cruisercpu])
      @cpuboard.cells.each_value.each{|v| ships << v.ship}
      expect(ships.compact).to include(@subcpu, @cruisercpu)
    # end
  end

  it "can place different ships" do
    # 25.times do
      ships = []
      @cpu.determine_cpu_placement([@subcpu, @cruisercpu,@subplayer,@cruiserplayer])
      @cpuboard.cells.each_value.each{|v| ships << v.ship}
      expect(ships).to include(@subcpu, @cruisercpu, @subplayer, @cruiserplayer)
    # end
  end
end
