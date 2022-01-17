# frozen_string_literal: true

require './lib/game_board'

describe GameBoard do
  describe '#initialize' do
    it 'creates 7x6 empty array by default' do
      game_board = GameBoard.new
      expect(game_board.grid).to eql([
        ['', '', '', '', '', '', ''],
        ['', '', '', '', '', '', ''],
        ['', '', '', '', '', '', ''],
        ['', '', '', '', '', '', ''],
        ['', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '']
      ])
    end
  end

  describe '#place_player_marker' do
    context 'when column is empty' do
      it 'places game piece into last row in column' do
        empty_board = GameBoard.new
        empty_board.place_player_marker(0, 'x')
        expect(empty_board.grid[5][0]).to eql('x')
      end

      it 'only places token into last row in column' do
        empty_board = GameBoard.new
        empty_board.place_player_marker(0, 'x')
        expect(empty_board.grid[4][0]).not_to eql('x')
        expect(empty_board.grid[3][0]).not_to eql('x')
        expect(empty_board.grid[2][0]).not_to eql('x')
        expect(empty_board.grid[1][0]).not_to eql('x')
        expect(empty_board.grid[0][0]).not_to eql('x')
      end
    end

    context 'when column is partially filled' do
      it 'places game piece into lowest available space in column' do
        partial_board = GameBoard.new([
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['x', '', '', '', '', '', ''],
          ['x', '', '', '', '', '', ''],
          ['x', '', '', '', '', '', '']
        ])
        partial_board.place_player_marker(0, 'o')
        expect(partial_board.grid[2][0]).to eql('o')
      end
    end

    context 'when column is full' do
      it 'does not place game piece into column' do
        full_column = GameBoard.new([
          ['x', '', '', '', '', '', ''],
          ['x', '', '', '', '', '', ''],
          ['x', '', '', '', '', '', ''],
          ['x', '', '', '', '', '', ''],
          ['x', '', '', '', '', '', ''],
          ['x', '', '', '', '', '', '']
        ])
        expect{ full_column.place_player_marker(0, 'o') }.not_to change { full_column.grid }
      end
    end
  end

  describe "#game_over?" do
    context 'when four of the same marker are connected across a row' do
      it 'returns true' do
        win_board = GameBoard.new([
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', 'x', 'x', 'x', 'x', '', ''],
          ['', 'o', 'o', 'o', 'x', '', ''],
          ['', 'x', 'x', 'o', 'o', '', '']
        ])
        expect(win_board).to be_game_over
      end
    end

    context 'when four of the same marker are connected across a column' do

      it 'returns true' do
        win_board = GameBoard.new([
          ['', 'x', '', '', '', '', ''],
          ['', 'x', '', '', '', '', ''],
          ['', 'x', '', '', '', '', ''],
          ['', 'x', '0', '', '', '', ''],
          ['', 'o', 'x', '', '', '', ''],
          ['o', 'o', 'x', '', '', '', '']
        ])
        expect(win_board).to be_game_over
      end
    end

    context 'when four of the same marker are connected across a diagonal' do
      it 'returns true' do
        win_board = GameBoard.new([
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', 'x', '', '', '', '', ''],
          ['', '', 'x', '', '', '', ''],
          ['', '', '', 'x', '', '', ''],
          ['', '', '', '', 'x', '', '']
        ])
        expect(win_board).to be_game_over
      end

      it 'returns true' do
        win_board = GameBoard.new([
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', 'x', '', ''],
          ['', '', '', 'x', '', '', ''],
          ['', '', 'x', '', '', '', ''],
          ['', 'x', '', '', '', '', '']
        ])
        expect(win_board).to be_game_over
      end
    end

    context 'when no winning combination is present' do
      it 'returns false' do
        incomplete_board = GameBoard.new([
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', 'x', 'x', '', 'x', '', ''],
          ['', 'o', '', 'o', '', '', ''],
          ['', 'o', 'o', '', 'o', '', ''],
          ['', 'o', 'x', 'x', 'x', 'o', '']
        ])
        expect(incomplete_board).not_to be_game_over
      end
    end
  end

  describe '#full_board?' do
    context 'when all spots on the board are not filled' do
      it 'returns false' do
        incomplete_board = GameBoard.new([
          ['', '', '', '', '', '', 'x'],
          ['', '', '', 'o', 'x', '', ''],
          ['', 'x', 'x', '', 'x', '', ''],
          ['', 'o', '', 'o', '', '', ''],
          ['', 'o', 'o', '', 'o', '', ''],
          ['', 'o', 'x', 'x', 'x', 'o', '']
        ])
        expect(incomplete_board).not_to be_full_board
      end
    end

    context 'when all spots on the board are filled' do
      it 'returns true' do
        complete_board = GameBoard.new([
          ['x', 'o', 'x', 'x', 'x', 'o', 'x'],
          ['x', 'o', 'x', 'x', 'x', 'o', 'x'],
          ['x', 'o', 'x', 'x', 'x', 'o', 'x'],
          ['x', 'o', 'x', 'x', 'x', 'o', 'x'],
          ['x', 'o', 'x', 'x', 'x', 'o', 'x'],
          ['x', 'o', 'x', 'x', 'x', 'o', 'x']
        ])
        expect(complete_board).to be_full_board
      end
    end
  end

  describe '#col_full?' do
    context 'when column is full' do
      it 'returns true' do
        full_column = GameBoard.new([
          ['x', '', '', '', '', '', ''],
          ['x', '', '', '', '', '', ''],
          ['x', '', '', '', '', '', ''],
          ['x', '', '', '', '', '', ''],
          ['x', '', '', '', '', '', ''],
          ['x', '', '', '', '', '', '']
        ])
        expect(full_column.col_full?(0)).to eql(true)
      end
    end

    context 'when column is not full' do
      it 'returns false' do
        partial_column = GameBoard.new([
          ['', '', '', '', '', '', ''],
          ['x', '', '', '', '', '', ''],
          ['x', '', '', '', '', '', ''],
          ['x', '', '', '', '', '', ''],
          ['x', '', '', '', '', '', ''],
          ['x', '', '', '', '', '', '']
        ])
        expect(partial_column.col_full?(0)).to eql(false)
      end
    end
  end
end
