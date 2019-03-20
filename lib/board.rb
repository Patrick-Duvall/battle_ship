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



end
