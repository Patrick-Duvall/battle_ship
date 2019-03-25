class Ship

  attr_reader :name, :health, :length, :instances
  def initialize(name, health)
    @name = name
    @health = health
    @length = health

  end

  def sunk?
    @health < 1
  end

  def hit
    @health -= 1
  end

end
