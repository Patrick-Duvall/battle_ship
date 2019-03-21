require "./lib/ship"
require "./lib/cell"

class Board
    attr_reader :cells, :size
  def initialize
    @cells = {}
    @size = 4
  end
  def cell_gen(num=4)
    @size = num
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



  # def valid_consecutive?(ship, placement_array)
  #   letters = placement_array.map{|el| el[0]}
  #   numbers = placement_array.map{|el| el[1].to_i}
  #
  #   same = letters.all?{|letter| letter == letters[0]} ? "letter" : "number"
  #   same = "letter" if letters.all?{|letter| letter == letters[0]}
  #   same = "number" if numbers.all?{|number| numbers == numbers[0]}
  #   if same == "letter"
  #     consecutive = numbers.chunk_while do |current, next_el|
  #       current+1 == next_el || current-1 == next_el
  #     end
  #     consecutive.to_a.length == 1
  #   elsif same == "number"
  #     consecutive = letters.chunk_while{ |current, next_el|
  #       current+1 == next_el || current-1 == next_el}
  #     consecutive.to_a.length == 1
  #   else
  #     false
  #   end
  # end


  def valid_consecutive?(ship, placement_array)
      letters = placement_array.map{|placement| placement[0]}
      numbers = placement_array.map{|placement| placement[1].to_i}
      #dont need "number", left in for readability"
      same = letters.uniq.length == 1 ? "letter" : "number"
      if same == "letter"
        consecutive = numbers.chunk_while do |current, next_el|
          current+1 == next_el || current-1 == next_el
        end
        else same == "number"
          #add map to_i to avoid conversion error
          consecutive = letters.map(&:to_i).chunk_while do |current, next_el|
            current+1 == next_el || current-1 == next_el
        end
      end
      consecutive.to_a.length == 1
    end



  def valid_bounds?(ship,placement_array)
   placement_array.all?{|placement| @cells.include?(placement)}
 end

 def place(ship, placement_array)
   placement_array.each{|placement| @cells[placement].place_ship(ship)}
 end

 def valid_overlap?(ship,placement_array)
   placement_array.all?{|placement| @cells[placement].empty?}

 end

 def valid_placement?(ship,placement_array)
   valid_bounds?(ship,placement_array) && valid_consecutive?(ship, placement_array)
 end

def render(visible = false)
  string = '  '
  @size.times{|num| string += "#{num + 1} "}

  string
end


end
