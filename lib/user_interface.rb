class UserInterface

  def initialize(game)
    @game = game
  end
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

  def choose_game_prompt
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
          @game.make_full_game
          answered = true
        when input.downcase == "s" || input.downcase == "small"
          @game.make_small_game
          answered = true
      end
    end
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
    @game.playerboard.cell_gen(input.to_i)
    @game.cpuboard.cell_gen(input.to_i)
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
      answered = (2..@game.playerboard.size - 2).to_a.include?(input.to_i)
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
          answered = (2..@game.playerboard.size - 1).to_a.include?(shiplength.to_i)
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
      shipstoplace = @game.playerships.length
      @game.playerships.each do |ship|
        puts "You have #{shipstoplace} ships left to place."
        puts "Please enter the spaces you would like to place your ships as a "
        + "single line"
        puts "An example is entering A1 A2 A3."
        print "\n"
        puts "Now placing #{ship.name}, it is " +
        "#{ship.length} units long."
        puts "Your board current board looks like:"
        puts @game.playerboard.render(true)
        yesorno = false
        while yesorno == false
        print "> "
        input = gets.chomp.upcase
        if @game.playerboard.valid_placement?(ship, input.split(' '))
          yesorno = false
          while yesorno == false
            puts "Are you sure you want to place your " +
            "#{ship.name} on squares #{input}?"
            puts "please enter yes or no."
            print "> "
            confirmplacement = gets.chomp.downcase
            case
              when confirmplacement == "y" || confirmplacement == "yes"
                puts "Placing your #{ship.name}."
                @game.playerboard.place(ship, input.split(' '))
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
      puts @game.cpuboard.render
      puts "==============PLAYER BOARD=============="
      puts @game.playerboard.render(true)
      print "\n"

      puts "Enter the coordinate for your shot:"
      shotyet = false
      while shotyet == false
        print "> "
        input = gets.chomp.upcase
        if @game.cpuboard.valid_coordinate?(input)
          yesorno = false
          puts "Are you sure you want to shoot at #{input}?"
          while yesorno == false
            puts "please enter yes or no."
            print "> "
            confirmshot = gets.chomp.downcase
            case
              when confirmshot == "y" || confirmshot == "yes"
                puts "Firing now!"
                @game.cpuboard.cells[input].fire_upon
                self.result_of_shot(input)
                yesorno = true
                shotyet = true
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

    def result_of_shot(coordinate)
      cellstate = @game.cpuboard.cells[coordinate].render
      case
      when cellstate == "M"
        puts "Your shot on #{coordinate} was a miss."
        #stand in for AI
        self.cpu_shot_message(@game.playerboard.cells.keys.sample)
      when cellstate == "H"
        puts "Your shot on #{coordinate} was a hit."
        self.cpu_shot_message(@game.playerboard.cells.keys.sample)
      when cellstate == "X"
        puts "Your shot on #{coordinate} sunk my #{@game.cpuboard.cells[coordinate].ship.name}!"
        @game.cpuships.delete_if{|ship| ship.name == @game.cpuboard.cells[chosencoordinate].ship.name}
        self.end_game if @game.cpuships.length == 0 || @game.playerships.length == 0
        self.cpu_shot_message(@game.playerboard.keys.sample)
      end
    end




  def cpu_shot_message(chosencoordinate)

    @game.playerboard.cells[chosencoordinate].fire_upon
    cellstate = @game.playerboard.cells[chosencoordinate].render
    case
      when cellstate == "M"
        puts "My shot on #{chosencoordinate} was a miss."
      when cellstate == "H"
        puts "My shot on #{chosencoordinate} was a hit."
      when cellstate == "X"
        puts "My shot on #{chosencoordinate} sunk your #{@game.playerboard.cells[chosencoordinate].ship.name}!"
        @game.playerships.delete_if{|ship| ship.name == @game.playerboard.cells[chosencoordinate].ship.name}
        self.end_game if @game.cpuships.length == 0 || @game.playerships.length == 0
    end
    self.turn_prompt
  end

  def end_game
    puts "Congratulations, you won!" if @game.cpuships.length == 0
    puts "I won!" if @game.playerships.length == 0
    print "\n"
    self.welcome
  end


end
