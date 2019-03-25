require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/game"
require "pry"




# @game = Game.new
@subplayer = Ship.new("Submarine", 2)
@cruiserplayer = Ship.new("Cruiser", 3)
@subcpu = Ship.new("Submarine", 2)
@cruisercpu = Ship.new("Cruiser", 3)

game = Game.new
game.cpu_board.place
