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

  # def array_increments_by?(array)
  #   sorted = array.sort
  #   lastNum = sorted[0]
  #   sorted[1, sorted.count].each do |el|
  #     if lastNum + step != el
  #       return false
  #     end
  #     lastNum = n
  #   end
  #   true
  # end

  def valid_consecutive?(ship, placement_array)
    counter = 0
    letters = placement_array.map{|el| el[0]}
    numbers = placement_array.map{|el| el[1].to_i}
    #refactoir?
    same = "letter" if letters[0] == letters[1]
    same = "number" if numbers[0] == numbers[1]
    binding.pry
    # if same == "letter"
    #   numbers.each.each{|enum|enum.next -1 == enum || enum.next +1 == enum}
    # else
    #   numbers.each.each{|enum|enum.next -1 == enum || enum.next +1 == enum}
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
