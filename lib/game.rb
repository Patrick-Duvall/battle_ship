class Game

  # def initialize
    # cpu_place_ship
  # end

  # user interaction tests

  def welcome
    p "Welcome to BATTLESHIP \n Enter p to play. Enter q to quit."
  end

  def place_ship_prompt
    p "I have laid out my ships on the grid."
    p "You now need to lay out your ships."
    answer = nil
    until answer.to_i #boardsize
      answer = gets.chomp
    end
    #baord size - min 4, max 10
    #ship stats?? ship number boardsize - 1
    #ship length boardsize - 1
    #cpu plays with same ships
    # if player says standard
    #
    # auto-size ship based on coordinates given?
  end

  # def standard_fleet
  #   @subplayer = Ship.new("Submarine", 2)
  #   @cruiserplayer = Ship.new("Cruiser", 3)
  # end

  def cpu_place_ship

  end
end
