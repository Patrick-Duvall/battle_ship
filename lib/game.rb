require "./lib/ship"
require "./lib/cell"
require "./lib/board"

class Game

  def initialize
    @ships = []
    @playerboard = Board.new
    @cpuboard = Board.new
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
        when input.downcase == "s" || input.downcase == "small"
          self.make_small_game
          answered = true
      end
    end
  end

  def make_full_game
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
        input = gets.chomp.downcase
        case
          when input == "y" || input == "yes"
            puts "Ship created!"
            customship = Ship.new(shipname, shiplength)
            @ships << customship
            yesorno = true
            shipsleft -= 1
          when input == "n" || input == "no"
            puts "Ship not created."
            yesorno = true
          end
        end
      end
    end

  def place_ship_prompt
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your ships."
    shipstoplace = @ships.length
    while shipstoplace > 0
      puts "You have #{shipstoplace} ships left to place."
      puts "Please enter the spaces you would like to place your ships as a "
      + "single line"
      puts "An example is entering A1 A2 A3."
      print "\n"
      puts "Now placing #{@ships.last.name}, it is #{@ships.last.length} "+
      "units long."
      puts "Your board current board looks like:"
      puts @playerboard.render(true)
      yesorno = false
      while yesorno == false
      print "> "
      input = gets.chomp.upcase
      if @playerboard.valid_placement?(@ships.last, input.split(' '))
        yesorno = false
        while yesorno == false
          puts "Are you sure you want to place your #{@ships.last.name} on " +
          "squares #{input}?"
          puts "please enter yes or no."
          print "> "
          confirmplacement = gets.chomp.downcase
          case
            when confirmplacement == "y" || confirmplacement == "yes"
              puts "Placing your #{@ships.last.name}."
              @playerboard.place(@ships.last, input.split(' '))
              @ships.pop
              shipstoplace -= 1
              yesorno = true
            when confirmplacement == "n" || confirmplacement == "no"
              puts "Aborting placement."
              yesorno = true
          end
        end
        else
          puts "Invalid placement, please try again."
        end
      end
    end
  end
end


g = Game.new

# g.welcome
# g.set_board_size
g.choose_game
g.place_ship_prompt
