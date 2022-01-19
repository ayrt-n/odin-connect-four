# frozen_string_literal: true

require './lib/connect_four_game'
require './lib/game_board'
require './lib/player'

describe ConnectFourGame do
  let(:p1) { double('p1', name: 'p1', marker: 'p1') }
  let(:p2) { double('p2', name: 'p2', marker: 'p2') }
  let(:board) { instance_double(GameBoard) }
  let(:game) { ConnectFourGame.new(p1, p2, board) }

  describe '#play' do
    before do
      allow(game).to receive(:intro_message)
      allow(board).to receive(:print_board)
      allow(game).to receive(:end_message)
      allow(game).to receive(:prompt_player_move).and_return('')
      allow(board).to receive(:place_player_marker)
      allow(game).to receive(:puts)
    end

    context 'when player wins game' do
      before do
        allow(board).to receive(:full_board?).and_return(false)
        allow(board).to receive(:game_over?).and_return(true)
      end

      it 'prompts player for move once and stops loop after player wins' do
        prompt_message = "p1! It's your turn! Select the column you would like to place your marker..."
        expect(game).to receive(:puts).with(prompt_message).once
        game.play
      end

      it 'sends place_player_marker to GameBoard' do
        expect(board).to receive(:place_player_marker)
        game.play
      end

      it 'sends game_over? to GameBoard' do
        expect(board).to receive(:game_over?)
        game.play
      end
    end

    context 'when player wins game after three turns' do
      before do
        allow(board).to receive(:full_board?).and_return(false)
        allow(board).to receive(:game_over?).and_return(false, false, true)
      end

      it 'prompts players for move three times and stops loop after player wins' do
        expect(game).to receive(:puts).exactly(3).times
        game.play
      end

      it 'sends rotate_current_player to game twice' do
        expect(game).to receive(:rotate_current_player).twice
        game.play
      end
    end

    context 'when the players move fills the board' do
      before do
        allow(board).to receive(:full_board?).and_return(false, true)
        allow(board).to receive(:game_over?).and_return(false)
      end

      it 'prompts player for move and then stops loop after the players move' do
        prompt_message = "p1! It's your turn! Select the column you would like to place your marker..."
        expect(game).to receive(:puts).with(prompt_message).once
        game.play
      end
    end
  end

  describe '#prompt_player_move' do
    context 'when provided valid move' do
      it 'sends valid_move? with player response to ConnectFourGame' do
        allow(game).to receive(:gets).and_return('1')
        allow(game).to receive(:valid_move?).and_return(true)
        expect(game).to receive(:valid_move?).with('1')
        game.send(:prompt_player_move)
      end

      it 'stops loop and does not display error message' do
        allow(game).to receive(:gets).and_return('')
        allow(game).to receive(:valid_move?).and_return(true)
        error_message = 'Invalid move - Please select a number 1-7 in column which is not full'
        expect(game).not_to receive(:puts).with(error_message)
        game.send(:prompt_player_move)
      end

      it 'returns player response as integer' do
        allow(game).to receive(:gets).and_return('1')
        allow(game).to receive(:valid_move?).and_return(true)
        player_response = game.send(:prompt_player_move)
        expect(player_response).to eql(0)
      end
    end

    context 'when provided invalid move once and then valid move' do
      it 'displays error message once and then stops loop' do
        allow(game).to receive(:gets).and_return('a', '1')
        allow(game).to receive(:valid_move?).and_return(false, true)
        error_message = 'Invalid move - Please select a number 1-7 in column which is not full'
        expect(game).to receive(:puts).with(error_message).once
        game.send(:prompt_player_move)
      end
    end
  end

  describe '#valid_move?' do
    context 'when move is valid' do
      it 'returns true' do
        allow(board).to receive(:col_full?).and_return(false)
        expect(game.send(:valid_move?, '1')).to eql(true)
      end
    end

    context 'when move invalid because column is full' do
      it 'returns false' do
        allow(board).to receive(:col_full?).and_return(true)
        expect(game.send(:valid_move?, '1')).to eql(false)
      end
    end

    context 'when move invalid because out of board range' do
      it 'returns false' do
        allow(board).to receive(:col_full?).and_return(false)
        expect(game.send(:valid_move?, '3029372')).to eql(false)
      end

      it 'returns false' do
        allow(board).to receive(:col_full?).and_return(false)
        expect(game.send(:valid_move?, 'invalid')).to eql(false)
      end
    end
  end

  describe '#rotate_current_player' do
    it 'changes the current player to other player' do
      prev_current_player = game.current_player
      game.send(:rotate_current_player)
      expect(game.other_player).to equal(prev_current_player)
    end
  end
end
