require "./lib/ship"
require "./lib/board"

class Game

  def initialize
    @ships = []
    @playerboard = Board.new
    @cpuboard = Board.new
  end

## Can build array with Nils BUT determine_cpu_placement rejects them
  def cpu_placement_direction(first_square, randomizer)
    case randomizer
      when 0
      square = first_square[0] +(first_square[1].ord.+1).to_s
      when 1
      square = first_square[0] +(first_square[1].ord.-1).to_s
    when 2
      square = ((first_square[0].ord) +1 ).to_s  + first_square[1]
    when 3
    first_square =((first_square[0].ord) +1 ).to_s  + first_square[1]
    end
    # square
  end

  def determine_cpu_placement(ship_array)
    placements = []
    i = 0
    randomizer = rand(4)
    while ship_array.length < i do
      first_square = @cpu_board.cells.keys.sample
      placement_array = [first_square]

      (ship.health-1).times do |coordinate|
        placement_array << cpu_placement_direction(first_square,randomizer)
      end

      if @cpu_board.valid_placement(ship_array[i], placement_array)
        placements << placement_array
         i +=1
      end
    end
    placements
  end

<<<<<<< HEAD
  #UI Logic
=======
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
>>>>>>> 13ebc48dc78050adc53f503016bb8ee0d38c9f49

  def choose_game_prompt
    puts "Would you like to play a small game, a full game, or a custom game?"
    answered = false
    while answered == false
      puts "Enter either small, full, or custom."
      print "> "
      input = STDIN.gets.chomp
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
      input = STDIN.gets.chomp
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

  def turn_prompt
    puts "=============COMPUTER BOARD============="
    puts @cpuboard.render
    puts "==============PLAYER BOARD=============="
    puts @playerboard.render(true)
    print "\n"

    puts "Enter the coordinate for your shot:"
    shotyet = false
    while shotyet == false
      print "> "
      input = gets.chomp.upcase
      if @cpuboard.valid_coordinate?(input)
        yesorno = false
        puts "Are you sure you want to shoot at #{input}?"
        while yesorno == false
          puts "please enter yes or no."
          print "> "
          confirmshot = gets.chomp.downcase
          case
            when confirmshot == "y" || confirmshot == "yes"
              puts "Firing now!"
              @cpuboard.fire_upon(input)
              yesorno = true
            when confirmshot == "n" || confirmshot == "no"
              puts "Aborting the shot."
              puts "Enter the coordinate for your shot:"
              yesorno = true
          end
        end
      else
        puts "Please enter a valid coordinate:"
      end
    end
  end
 #end UI logic
end


g = Game.new

# # g.welcome
# # g.set_board_size
# g.choose_game_prompt
# g.place_ship_prompt
# g.turn_prompt
