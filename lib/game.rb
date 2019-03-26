require "./lib/ship"
require "./lib/board"

class Game
  attr_reader :playerships, :cpuships, :playerboard, :cpuboard
  attr_writer :user_interface
  def initialize
    @playerships = []
    @cpuships = []
    @playerboard = Board.new
    @cpuboard = Board.new
    @user_interface = nil
    @computer = Computer.new
  end

  def make_full_game
    @playerboard.cell_gen(10)
    @cpuboard.cell_gen(10)
    destroyer = Ship.new("Destroyer", 2)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 3)
    battleship = Ship.new("battleship", 4)
    carrier = Ship.new("Carrier", 5)
    @playerships = [destroyer, cruiser, submarine, battleship, carrier]
    cpudestroyer = Ship.new("Destroyer", 2)
    cpucruiser = Ship.new("Cruiser", 3)
    cpusubmarine = Ship.new("Submarine", 3)
    cpubattleship = Ship.new("battleship", 4)
    cpucarrier = Ship.new("Carrier", 5)
    @cpuships = [cpudestroyer, cpucruiser, cpusubmarine, cpubattleship, cpucarrier]

  end

  def make_small_game
    @playerboard.cell_gen(4)
    @cpuboard.cell_gen(4)
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)
    @playerships = [cruiser, submarine]
    cpusubmarine = Ship.new("Submarine", 2)
    cpucruiser = Ship.new("Cruiser", 3)
    @cpuships = [cpucruiser, cpusubmarine]

  end

  def make_custom_ship_for_both_players(name, length)
    playercustomship = Ship.new(name, length)
    @playerships << playercustomship
    cpucustomship = Ship.new(name, length)
    @cpuships << cpucustomship
  end

  def play_game
    @user_interface.welcome
    @user_interface.choose_game_prompt
    @computer
    @user_interface.place_ship_prompt
    @user_interface.turn_prompt


  end


end
