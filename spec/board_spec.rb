require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "pry"
describe Board do

  before do
    @board = Board.new
    @cell_a1 = Cell.new('A1')
    @cell_a2 = Cell.new('A2')
    @cell_b1 = Cell.new('B1')
    @cell_b2 = Cell.new('B2')
  end


  context "generate board" do
    before do
      @board.cell_gen()
      @cruiser = Ship.new("Cruiser", 3)
      @submarine = Ship.new("Submarine", 2)
    end
    it "has cells" do
      (@board.cells).each{|cell| expect cell.is_a?(Cell)}
      expect(@board.cells['A1'].coordinate).to eq(@cell_a1.coordinate)
      expect(@board.cells['B2'].coordinate).to eq(@cell_b2.coordinate)
    end

    it "validates coordinates" do
      expect(@board.valid_coordinate?("A1"))
      expect(@board.valid_coordinate?("D4"))
      !expect(@board.valid_coordinate?("A5"))
      !expect(@board.valid_coordinate?("E1"))
      !expect(@board.valid_coordinate?("A22"))
    end

    it "validates ship placements" do
      #check length
      !expect(@board.valid_placement?(@cruiser, ["A1", "A2"]))
      !expect(@board.valid_placement?(@submarine, ["A1", "A2", "A3"]))
      #check consecutive
      !expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"]))
      !expect(@board.valid_placement?(@submarine, ["A1", "C1"]))
      !expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"]))
      !expect(@board.valid_placement?(@submarine, ["C1", "B1"]))
      #!diagonal
      !expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"]))
      !expect(@board.valid_placement?(@submarine, ["C2", "D3"]))
      #valid placements
      expect(@board.valid_placement?(@submarine, ["A1", "A2"]))
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"]))

    end

  end
end
