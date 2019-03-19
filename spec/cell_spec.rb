require "rspec/autorun"
require "./lib/ship"
require "./lib/cell"
describe Cell do

  before do
    @cell = Cell.new("B4")
    @ship = Ship.new("Cruiser", 3)
  end

  it "exists" do
    expect(@cell).to be_a(Cell)
  end

  
end
