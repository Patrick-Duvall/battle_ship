require "./lib/ship"
require "./lib/cell"

class Board
    attr_reader :cells
  def initialize
    @cells = {}
  end
  def cell_gen(num=4)
    # 64 to avoid off by 1 error
    letters = ("A".."#{(64 + num).chr}").to_a
    numbers = ("1".."#{num}").to_a
    letters.each do |letter|
      numbers.each do |number|
        @cells[(letter+number)] = Cell.new(letter + number)
      end
    end
  end

  def valid_coordinate?(coordinate)
    @cells.include?(coordinate)
  end

  def valid_length?(ship, placement_array)
    ship.length == placement_array.length
  end
#letters same nums consec or nums same letters consec
  def valid_consecutive?(ship, placement_array)
    counter = 0
    letters = placement_array.map{|el| el[0]}
    numbers = placement_array.map{|el| el[1]}
    #refactoir?
    same = "letter" if letters[0] == letters[1]
    same = "number" if numbers[0] == numbers[1]
    if same == "letter"
      numbers.each_cons(ship.length)
    else
      letters.each_cons(ship.length)
    end

    # counter = 0
    # direction = ''
    # placement_array.each do |placement|
    #   binding.pry
    #   letter = placement[0].ord
    #   number = placement[1]
    # end
  end
  #
  # def in_bounds
  # => all?
  # end
  #
  # def does_not_overlap
  #
  # end


  def valid_placement?(ship, placement_array)
    valid_length(ship, placement_array)
  end

end
