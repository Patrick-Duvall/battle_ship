require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/game"
require "stringio"
require 'o_stream_catcher'
require "pry"

<<<<<<< HEAD
class Game
  attr_reader :playerships, :cpuships, :playerboard, :cpuboard
  attr_writer :user_interface
=======

class Game
  attr_reader :playerboard, :cpuboard
>>>>>>> f12098fd6f169ea9c84ffcc0ef1f2ca6e59410f8
  def initialize
    @playerships = []
    @cpuships = []
    @playerboard = Board.new
    @cpuboard = Board.new
<<<<<<< HEAD
    @user_interface = nil
    @computer = Computer.new
=======
  end

## Can build array with Nils BUT determine_cpu_placement rejects them
  def cpu_placement_direction(first_square, randomizer)
    case randomizer
      when 0
      square = first_square[0] +((first_square[1].to_i)+1).to_s
      when 1
      square = first_square[0] +((first_square[1].to_i) -1).to_s
    when 2
      square = ((first_square[0].ord) +1 ).chr  + first_square[1]
    when 3
    first_square =((first_square[0].ord) -1 ).chr  + first_square[1]
    end
  end

  def determine_cpu_placement(ship_array)
    placements = []
    i = 0
    randomizer = rand(4)
    while i < ship_array.length do
      first_square = @cpuboard.cells.keys.sample
      placement_array = [first_square]
      (ship_array[i].health-1).times do |coordinate|
        first_square = cpu_placement_direction(first_square,randomizer)
        placement_array << first_square
      end
      if @cpuboard.valid_placement?(ship_array[i], placement_array)
        placements << placement_array
         i +=1
      end
    end
    binding.pry
    placements
  end

  def cpu_place_ships
    placements = determine_cpu_placement(@cpuships)
    counter = 0
    @cpuships.each do |ship|
       @cpuboard.place(ship, placements[0])
       counter +=1
    end
  end

  def welcome
    puts "Welcome to BATTLESHIP"
    input = ''
    until input == 'p'
      puts "Enter p to play. Enter q to quit.\n"
      input = STDIN.gets.chomp
      case
        when input.downcase == "p"
          "play"
        when input.downcase == "q"
          puts "Thanks for playing!"
          exit
        end
    end
  end

  def choose_game_prompt
    puts "Would you like to play a (s)mall game, a (f)ull game, or a (c)ustom game?"
    input = ''
    until input == 'custom' || input == 'full' || input == 'small'
      puts "Enter either small, full, or custom."
      print "> "
      input = STDIN.gets.chomp
      case
      when input.downcase == "c" || input.downcase == "custom"
          retval ='custom'
      when input.downcase == "f" || input.downcase == "full"
          retval ='full'
      when input.downcase == "s" || input.downcase == "small"
          retval ='small'
      end
    end
    retval
>>>>>>> f12098fd6f169ea9c84ffcc0ef1f2ca6e59410f8
  end

  def make_full_game
    @playerboard.cell_gen(10)
    @cpuboard.cell_gen(10)
    destroyer = Ship.new("Destroyer", 2)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 3)
    battleship = Ship.new("battleship", 4)
    carrier = Ship.new("Carrier", 5)
    @playerships += [destroyer, cruiser, submarine, battleship, carrier]
    cpudestroyer = Ship.new("Destroyer", 2)
    cpucruiser = Ship.new("Cruiser", 3)
    cpusubmarine = Ship.new("Submarine", 3)
    cpubattleship = Ship.new("battleship", 4)
    cpucarrier = Ship.new("Carrier", 5)
<<<<<<< HEAD
    @cpuships = [cpudestroyer, cpucruiser, cpusubmarine, cpubattleship, cpucarrier]
=======
    @cpuships += [cpudestroyer, cpucruiser, cpusubmarine, cpubattleship, cpucarrier]
>>>>>>> f12098fd6f169ea9c84ffcc0ef1f2ca6e59410f8

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
<<<<<<< HEAD

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

=======
  end

  def custom_board_size
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
  end

  def custom_number_of_ships
    puts "How many ships would you like to play with?"
    input = ''
      until input.to_i > 1 && input.to_i <= @cpuboard.size - 2
      puts "Enter a number between 2 and #{(@cpuboard.size) - 2}, inclusive\n>"
      input = STDIN.gets.chomp
    end
    input
  end

  def make_custom_fleet(shipsleft)
    while shipsleft > 0
      puts "You have #{shipsleft} ships left to create."
      puts "What should this ship be named?"
      print "> "
      shipname = STDIN.gets.chomp
        answered = false
        while answered == false
          puts "How long should this ship be?"
          puts "Enter only a single number. The minimum is 2, and the " +
          "maximum is one less then the length of the board.\n> "
          shiplength = STDIN.gets.chomp
          answered = (2..@playerboard.size - 1).to_a.include?(shiplength.to_i)
        end
      puts "So, we're creating a ship called #{shipname} that is " +
      "#{shiplength} units long?"
      yesorno = false
      while yesorno == false
        puts "please enter yes or no.\n> "
        input = STDIN.gets.chomp.downcase
        case
          when input == "y" || input == "yes"
            puts "Ship created!"
            playercustomship = Ship.new(shipname, shiplength)
            @playerships << playercustomship
            cpucustomship = Ship.new(shipname, shiplength)
            @cpuships << cpucustomship
            yesorno = true
            shipsleft -= 1
          when input == "n" || input == "no"
            puts "Ship not created."
            yesorno = true
          end
        end
      end
    end

  def make_game(game_type)
    case game_type
    when 'small'
      make_small_game
    when 'full'
      make_full_game
    when 'custom'
      custom_board_size
      shipnum = custom_number_of_ships
      make_custom_fleet(shipnum.to_i)
    end
  end



  def place_ship_prompt
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your ships."
    shipstoplace = @playerships.length
    @playerships.each do |ship|
      puts "You have #{shipstoplace} ships left to place."
      puts "Please enter the spaces you would like to place your ships as a "
      + "single line"
      puts "An example is entering A1 A2 A3."
      print "\n"
      puts "Now placing #{ship.name}, it is " +
      "#{ship.length} units long."
      puts "Your board current board looks like:"
      puts @playerboard.render(true)
      yesorno = false
      while yesorno == false
      print "> "
      input = STDIN.gets.chomp.upcase
      if @playerboard.valid_placement?(ship, input.split(' '))
        yesorno = false
        while yesorno == false
          puts "Are you sure you want to place your " +
          "#{ship.name} on squares #{input}?"
          puts "please enter yes or no."
          print "> "
          confirmplacement = STDIN.gets.chomp.downcase
          case
            when confirmplacement == "y" || confirmplacement == "yes"
              puts "Placing your #{ship.name}."
              @playerboard.place(ship, input.split(' '))
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
    puts "\nEnter the coordinate for your shot:\n>"
    input = ''
    until @cpuboard.cells.keys.include?(input)
    input = STDIN.gets.chomp.upcase
      if @cpuboard.valid_coordinate?(input)
        puts "Firing now!"
        sleep 2
        @cpuboard.cells[input].fire_upon
      else
        puts "Please enter a valid coordinate:"
      end
    end
    input
  end

  def result_of_shot(coordinate)
    cellstate = @cpuboard.cells[coordinate].render
    case
    when cellstate == "M"
      puts "Your shot on #{coordinate} was a miss."
    when cellstate == "H"
      puts "Your shot on #{coordinate} was a hit."
    when cellstate == "X"
      puts "Your shot on #{coordinate} sunk my #{@cpuboard.cells[coordinate].ship.name}!"
      game_over_message if game_over?
    end
  end

  def cpu_shot
    coordinate = @playerboard.cells.keys.sample until !already_shot.include?(coordinate)
    already_shot = []
    already_shot << coordinate

    @playerboard.cells[coordinate].fire_upon
    cellstate = @playerboard.cells[coordinate].render
    case
      when cellstate == "M"
        puts "My shot on #{coordinate} was a miss."
      when cellstate == "H"
        puts "My shot on #{coordinate} was a hit."
      when cellstate == "X"
        puts "My shot on #{coordinate} sunk your #{@playerboard.cells[coordinate].ship.name}!"
        game_over_message if game_over?
    end
  end
>>>>>>> f12098fd6f169ea9c84ffcc0ef1f2ca6e59410f8

  def game_over?
    @cpuships.all?(&:sunk?) || @playerships.all?(&:sunk?)

  end

  def game_over_message
    puts @cpuships.all?(&:sunk?) == 0 ? "Congratulations, you won!" : "I won"
  end

  def play_turns
    until game_over?
      result_of_shot(turn_prompt)
      cpu_shot
    end
  end

  def play_game
    welcome
    make_game(choose_game_prompt)
    cpu_place_ships
    place_ship_prompt
    play_turns
    sleep 3
    welcome
  end
end
<<<<<<< HEAD
=======




g = Game.new

g.play_game
# g.set_board_size
# g.choose_game_prompt
# g.place_ship_prompt
# g.turn_prompt
>>>>>>> f12098fd6f169ea9c84ffcc0ef1f2ca6e59410f8
