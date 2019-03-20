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

  def valid_consecutive?(ship, placement_array)
    counter = 0
    letters = placement_array.map{|el| el[0]}
    numbers = placement_array.map{|el| el[1].to_i}
    same = "letter" if letters.all?{|letter| letter == letters[0]}
    same = "number" if numbers.all?{|number| numbers == numbers[0]}
    if same == "letter"
      consecutive = numbers.chunk_while do |current, nextelement|
        current+1 == nextelement || current-1 == nextelement
      end
      consecutive.to_a.length == 1
    elsif same == "number"
      consecutive = letters.chunk_while do |current, nextelement|
        current+1 == nextelement || current-1 == nextelement
      end
      consecutive.to_a.length == 1
    else
      return false
    end
  end

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
