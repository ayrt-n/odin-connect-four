# frozen_string_literal: true

# Class representation of connect four game board (grid)
class GameBoard
  attr_reader :grid

  def initialize(grid = Array.new(6) { Array.new(7, '') })
    @grid = grid
  end

  def place_player_marker(col, marker)
    5.downto(0).each do |row|
      if grid[row][col].empty?
        grid[row][col] = marker
        break
      end
    end
  end

  def game_over?
    winning_row? || winning_column? || winning_diagonal?
  end

  def full_board?
    grid.each do |row|
      return false if row.include?('')
    end
    true
  end

  def col_full?(col)
    column = [grid[0][col],
              grid[1][col],
              grid[2][col],
              grid[3][col],
              grid[4][col],
              grid[5][col]]
    !column.include?('')
  end

  def print_board
    puts ''
    puts '  1  2  3  4  5  6  7 '
    grid.each do |row|
      print '|'
      row.each do |element|
        if element.empty?
          print '   '
        else
          print " #{element} "
        end
      end
      puts '|'
    end
    puts ''
  end

  private

  def winning_row?
    grid.each do |row|
      next if row.all?(&:empty?)

      row.each_cons(4) do |sub_row|
        next if sub_row.include?('')

        return true if sub_row.uniq.size == 1
      end
    end
    false
  end

  def winning_column?
    grid.transpose.each do |col|
      next if col.all?(&:empty?)

      col.each_cons(4) do |sub_col|
        next if sub_col.include?('')

        return true if sub_col.uniq.size == 1
      end
    end
    false
  end

  def winning_diagonal?
    (0..5).each do |row|
      (0..6).each do |col|
        if row < 3 && col < 4 # Diagonal needs space to allow four to connect
          diagonal = [grid[row][col], 
                      grid[row + 1][col + 1],
                      grid[row + 2][col + 2],
                      grid[row + 3][col + 3]]

          next if diagonal.include?('')
          return true if diagonal.uniq.size == 1
        elsif row > 2 && col < 4 # Diagonal needs space to allow four to connect
          diagonal = [grid[row][col], 
                      grid[row - 1][col + 1],
                      grid[row - 2][col + 2],
                      grid[row - 3][col + 3]]

          next if diagonal.include?('')
          return true if diagonal.uniq.size == 1
        end
      end
    end
    false
  end
end
