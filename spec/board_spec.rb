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

  it "has cells" do
    @board.cell_gen()
    (@board.cells).each{|cell| expect cell.is_a?(Cell)}
    expect(@board.cells['A1'].coordinate).to eq(@cell_a1.coordinate)
    expect(@board.cells['B2'].coordinate).to eq(@cell_b2.coordinate)

  end
end
