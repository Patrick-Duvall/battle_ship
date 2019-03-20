class Cell

  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @ship.hit if @ship != nil
    @fired_upon = true
  end

  def render(visable = false)
    return "S" if !empty? && visable
    case
      when !@fired_upon
        "."
      when @fired_upon && empty?
        "M"
      when !empty? && @fired_upon && !@ship.sunk?
        "H"
      when !empty? && @ship.sunk?
        "X"
    end
  end
end
