require "./lib/ship"
require "./lib/cell"
require "./lib/board"

class Game

  def initialize
    @ships = []
  end

  # user interaction tests

  def welcome
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    answered = false
    while answered == false
      print "> "
      input = gets.chomp
      case
        when input.downcase == "p" || input.downcase == "play"
          print "\n"
          answered = true
        when input.downcase == "q" || input.downcase == "quit"
          puts "Thanks for playing!"
          exit
      end
    end
  end

  def choose_game
    puts "Would you like to play a small game, a full game, or a custom game?"
    puts "Enter either small, full, or custom."
    answered = false
    while answered == false
      print "> "
      input = gets.chomp
      case
        when input.downcase == "c" || input.downcase == "custom"
          self.set_board_size
          answered = true
        when input.downcase == "f" || input.downcase == "full"
          self.make_full_game
          answered = true
        when input.downcase == "s" || input.downcase == "standard"
          self.make_small_game
          answered = true
      end
    end
  end

  def make_full_game
    @playerboard = Board.new
    @cpuboard = Board.new
    @playerboard.cell_gen(10)
    @cpuboard.cell_gen(10)
    destroyer = Ship.new("Destroyer", 2)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 3)
    battleship = Ship.new("battleship", 4)
    carrier = Ship.new("Carrier", 5)
    @ships = [destroyer, cruiser, submarine, battleship, carrier]
  end

  def make_small_game
    @playerboard = Board.new
    @cpuboard = Board.new
    @playerboard.cell_gen(4)
    @cpuboard.cell_gen(4)
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)
    @ships = [cruiser, submarine]
  end

  def set_board_size
    answered = false
    while answered == false
      puts "Please select the size of the board."
      puts "Enter only a single number, between 4 and 10, for the size."
      print "> "
      input = gets.chomp
      answered = (4..10).to_a.include?(input.to_i)
    end
    print "\n"
    @playerboard = Board.new
    @cpuboard = Board.new
    @playerboard.cell_gen(input.to_i)
    @cpuboard.cell_gen(input.to_i)
    self.make_custom_fleet
  end

  def make_custom_fleet
    puts "How many ships would you like to play with?"
  end

  def place_ship_prompt
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your ships."
    answer = nil
    until answer.to_i #boardsize
      answer = gets.chomp
    end
  end
end

# 
# g = Game.new
#
# g.welcome
# g.set_board_size
# g.choose_game
