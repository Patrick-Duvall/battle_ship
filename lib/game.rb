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
    answered = false
    while answered == false
      puts "Enter p to play. Enter q to quit."
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
    answered = false
    while answered == false
      puts "Enter either small, full, or custom."
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
    puts "Please select the size of the board."
    answered = false
    while answered == false
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
    self.number_of_ships
  end

  def number_of_ships
    puts "How many ships would you like to play with?"
    answered = false
    while answered == false
      puts "Enter only a single number. The minimum is 2, and the maximum is " +
      "two less then the length of the board."
      print "> "
      input = gets.chomp
      answered = (2..@playerboard.size - 2).to_a.include?(input.to_i)
    end
    self.make_custom_fleet(input.to_i)
  end

  def make_custom_fleet(shipsleft)
    while shipsleft > 0
      puts "You have #{shipsleft} ships left to create."
      puts "What should this ship be named?"
      print "> "
      shipname = gets.chomp
        answered = false
        while answered == false
          puts "How long should this ship be?"
          puts "Enter only a single number. The minimum is 2, and the " +
          "maximum is one less then the length of the board."
          print "> "
          shiplength = gets.chomp
          answered = (2..@playerboard.size - 1).to_a.include?(shiplength.to_i)
        end
      puts "So, we're creating a ship called #{shipname} that is " +
      "#{shiplength} units long?"
      yesorno = false
      while yesorno == false
        puts "please enter yes or no."
        print "> "
        input = gets.chomp
        case
          when input.downcase == "y" || input.downcase == "yes"
            puts "Ship created!"
            customship = Ship.new(shipname, shiplength)
            @ships << customship
            yesorno = true
            shipsleft -= 1
          when input.downcase == "n" || input.downcase == "no"
            puts "Ship not created."
            yesorno = true
          end
        end
      end
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


g = Game.new

g.welcome
g.set_board_size
g.choose_game
