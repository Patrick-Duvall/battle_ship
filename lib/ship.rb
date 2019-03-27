class Ship

  attr_reader :name, :health, :length, :instances
  def initialize(name, health)
    @name = name
    @health = health.to_i
    @length = health.to_i

  end

  def sunk?
    @health < 1
  end

  def hit
    @health -= 1
  end

end
