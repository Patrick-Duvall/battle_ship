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

  def cpu_placement_direction(first_square, board_size)
    randomizer = 0
    case randomizer
      when 0
      square = first_square[0] +((first_square[1].ord.+1) % @cpu_board.size ).to_s
    # when 1
    #   square = first_square[0] +(square_1[1].ord.-1) % @cpu_board.size )
    # when 2
    #   square = (first_square[0] +1) +square_1[1]
    # when 0
    #   square = (first_square[0] -1) + square_1[1]

    end

  end

  def determine_cpu_placement(ship_array)
    placements = []
    i = 0
    while ship_array.length < i do
      first_square = @cpu_board.cells.keys.sample
      placement_array = [square_1]

      (ship.health-1).times do |coordinate|

        # cpu_placement_direction
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
