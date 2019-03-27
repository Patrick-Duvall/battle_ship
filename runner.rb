require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/computer"
require "./lib/user_interface"
require "./lib/game"
require 'o_stream_catcher'
require "pry"


game = Game.new
ui = UserInterface.new(game)
game.user_interface = ui

game.play_game
