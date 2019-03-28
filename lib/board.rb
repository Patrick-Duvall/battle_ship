require "./lib/cell"

class Board
    attr_reader :cells, :size, :letters, :numbers
  def initialize
    @cells = {}
    @size = 4
  end

  def cell_gen(num=4)
    @size = num
    @letters = ("A".."#{(64 + num).chr}").to_a
    @numbers = ("1".."#{num}").to_a
    @letters.each do |letter|
      @numbers.each do |number|
        @cells[(letter+number)] = Cell.new(letter + number)
      end
    end
  end

  def valid_coordinate?(coordinate)
    @cells.include?(coordinate) && !@cells[coordinate].fired_upon?
  end

  def valid_length?(ship, placement_array)
    ship.length == placement_array.length
  end

  def valid_consecutive?(ship, placement_array)
    letters = placement_array.map{|placement| placement[0].ord}
    numbers = placement_array.map{|placement| placement[1].to_i}
    if letters.uniq.length == 1
      same = "letter"
    elsif numbers.uniq.length == 1
      same = "number"
    else
      false
    end
    if same == "letter"
      consecutive = numbers.chunk_while do |current, next_el|
        current+1 == next_el || current-1 == next_el
      end
    else same == "number"
      consecutive = letters.chunk_while do |current, next_el|
        current+1 == next_el || current-1 == next_el
      end
    end
    consecutive.to_a.length == 1
  end

  def valid_bounds?(placement_array)
   placement_array.all?{|placement| @cells.include?(placement)}
 end

 def valid_overlap?(placement_array)
   placement_array.all?{|placement| @cells[placement].empty?} && \
   placement_array.uniq.length == placement_array.length
 end

 def valid_placement?(ship, placement_array)
   valid_bounds?(placement_array) && 
   valid_consecutive?(ship, placement_array) && \
   valid_length?(ship, placement_array) && \
   valid_overlap?(placement_array)
 end

 def place(ship, placement_array)
   placement_array.each{|placement| @cells[placement].place_ship(ship)}
 end

 def render(visible = false)
    string = '  '
    @size.times{|num| string += "#{num + 1} "}
    string +="\n"
    counter = 0
    @size.times do |i|
      string += "#{@letters[i]} "
      @size.times do
        string += "#{@cells.values[counter].render(visible)} "
        counter +=1
      end
    string += "\n"
    end
    string
  end


end
