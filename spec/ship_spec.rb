require "./lib/ship"
describe Ship do

  before do
    @ship = Ship.new("Cruiser", 3)
  end

  it "exists" do
    expect(@ship).to be_a(Ship)
  end

  it "has attributes" do
    expect(@ship.name).to eq("Cruiser")
    expect(@ship.length).to eq(3)
    expect(@ship.health).to eq(3)
    expect(@ship.sunk?).to eq(false)
  end

  it "hits cause loss of health" do
   @ship.hit
    expect(@ship.health).to eq(2)
    @ship.hit
    expect(@ship.health).to eq(1)
  end

  it "sinks at 0 health" do
    expect(@ship.sunk?).to eq(false)
    3.times{@ship.hit}
    expect(@ship.sunk?).to be(true)
  end
end
