# frozen_string_literal: true

# Test code to make sure that winning_diagonal? method captures all possible diagonals on 6x7 grid
grid = Array.new(6) { Array.new(7, '') }

def print_diagonals(grid)
  (0..5).each do |row|
    (0..6).each do |col|
      if row < 3 && col < 4 # Diagonal needs space to allow four to connect
        puts "[grid[#{row}][#{col}], grid[#{row + 1}][#{col + 1}], grid[#{row + 2}][#{col + 2}], grid[#{row + 3}][#{col + 3}]]"
      elsif row > 2 && col < 4 # Diagonal needs space to allow four to connect
        puts "[grid[#{row}][#{col}], grid[#{row - 1}][#{col + 1}], grid[#{row - 2}][#{col + 2}], grid[#{row - 3}][#{col + 3}]]"
      end
    end
  end
  false
end

print_diagonals(grid)
