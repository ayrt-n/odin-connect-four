# frozen_string_literal: true

# Class representation of Connect 4 game flow
class ConnectFourGame
  attr_reader :current_player, :other_player, :board

  def initialize(p1, p2, board = GameBoard.new)
    @current_player = p1
    @other_player = p2
    @board = board
  end

  def play
    intro_message
    until board.full_board?
      board.print_board
      puts "#{current_player.name}! It's your turn! Select the column you would like to place your marker..."
      move = prompt_player_move
      board.place_player_marker(move, current_player.marker)

      break if board.game_over?

      rotate_current_player
    end
    end_message
  end

  private

  def intro_message
    puts <<~HEREDOC

      Welcome to Ruby Connect Four!

      The goal of the game is to connect four of your tokens 
      while preventing your opponent from doing the same.
      Players will take turns dropping tokens into the grid.

      Have fun and good luck!
    HEREDOC
  end

  def end_message
    if board.full_board?
      puts 'Draw game! There was no winner.'
    else
      puts "Congrats #{current_player.name}, you won!\nBetter luck next time, #{other_player.name}!"
    end
  end

  def rotate_current_player
    @current_player, @other_player = other_player, current_player
  end

  def prompt_player_move
    loop do
      input = gets.chomp
      return input.to_i if valid_move?(input)

      puts 'Invalid move - Please select a number 0-6 in column which is not full'
    end
  end

  def valid_move?(col)
    !!(col.match(/^\b[0-6]\b/) && !board.col_full?(col.to_i))
  end
end
