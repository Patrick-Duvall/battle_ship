require "rspec/autorun"
require "./lib/ship"
describe Ship do

  before do
      @ship = Ship.new("Cruiser", 3)
    end

    it "exists" do
      expect(@ship).to be_a(Ship)
    end

    it "has_attributes" do
      expect(@ship.name).to eq("Cruiser")
      expect(@ship.length).to eq(3)
      expect(@ship.health).to eq(3)
      expect(@ship.sunk?).to eq(false)
    end

  end
