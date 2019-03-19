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

  it "has coordinate" do
    expect(@cell.coordinate).to eq("B4")
  end

  it "does not have a ship by default" do
    expect(@cell.ship).to eq(nil)
    expect(@cell.empty?).to eq(true)
  end
  it "has a ship when placed" do
    expect(@cell.ship).to eq(@ship)
    expect(@cell.empty?).to eq(false)
  end

  it "may be fired upon" do
    expect(@cell.fired_upon?).to eq(false)
    @cell.fire_upon
    expect(@cell.fired_upon?).to eq(true)
  end

  it "being fired_upon reduces ship health" do
    @cell.place_ship(@ship)
    expect(@cell.ship.health).to eq(3)
    @cell.fire_upon
    expect(@cell.ship.health).to eq(2)
    @cell.fire_upon
    expect(@cell.ship.health).to eq(1)
  end


end
