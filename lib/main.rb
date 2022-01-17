# frozen_string_literal: true

require './lib/connect_four_game'
require './lib/game_board'
require './lib/player'

# Example game:

player_1 = Player.new('Ayrton', '☮')
player_2 = Player.new('Vicky', '☯')

ConnectFourGame.new(player_1, player_2).play
