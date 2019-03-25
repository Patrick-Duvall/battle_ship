class Game

  # def initialize
    # cpu_place_ship
  # end

  attr_reader :cpu_board, :player_board
def initialize(num=4)
  @cpu_board = Board.new
  @player_board = Board.new
  @cpu_board.cell_gen(num)
  @player_board.cell_gen(num)

end

  def welcome
    p "Welcome to BATTLESHIP \n Enter p to play. Enter q to quit."
    response = gets.strip

  end
## may still break on edge cases
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
square
  end

  def determine_cpu_placement(ship_array)
    placements = []
    i = 0
    randomizer = rand(4)
    while ship_array.length < i do
      first_square = @cpu_board.cells.keys.sample
      placement_array = [first_square]

      (ship.health-1).times do |coordinate|
        placement_array << cpu_placement_direction(first_square, ship_array[i],randomizer)

      end
      if @cpu_board.valid_placement(ship_array[i], placement_array)
        placements << placement_array
         i +=1
      end
    end
    placements
  end

  def cpu_place
    @cpu_board.place_ship
  end

end
