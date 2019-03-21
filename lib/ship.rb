require "pry"
class Ship


#   @@number_of = 0
# def self.number_of
#   @@number_of
# end

  attr_reader :name, :health, :length, :instances
  def initialize(name, health)
    # @@number_of +=1
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
