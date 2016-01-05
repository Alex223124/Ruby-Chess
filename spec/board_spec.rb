require 'rspec'
require 'bishop'
require 'jumping_pieces'
require 'king'
require 'knight'
require 'pawn'
require 'piece'
require 'queen'
require 'rook'
require 'sliding_pieces'
require 'board'
require 'graphic'

describe 'Board' do
  
  subject(:board) { Board.new(8) }

  it 'should initialize 8 white pawns' do 
    expect(board.cell.any? { |x| x.all? { |y| y.class == Pawn && y.color == :White}}).to eq(true)
  end

  it 'should initialize 8 black pawns' do 
    expect(board.cell.any? { |x| x.all? { |y| y.class == Pawn && y.color == :Black}}).to eq(true)
  end

  describe '#cant_get_out_of_check?' do 

    it 'should return true if piece is in checkmate' do 
      #checkmate sequence
      board.execute_move([6,5],[4,5])
      board.execute_move([1,4],[2,4])
      board.execute_move([6,6],[4,6])
      board.execute_move([0,3],[4,7])

      expect(board.cant_get_out_of_check?(:White)).to eq(true)
    end

    it 'should return false if the piece can get out of check' do
      # in check, but not checkmate
      board.execute_move([6,5],[4,5]) #white
      board.execute_move([1,4],[2,4])
      board.execute_move([6,6],[4,6])
      board.execute_move([0,3],[3,6])
      board.execute_move([6,4],[4,4])
      board.execute_move([3,6],[4,7])

      expect(board.cant_get_out_of_check?(:White)).to eq(false)
    end

  end

  describe '#in_check?' do 
    it 'should return true if that color is in check' do
      board.cell[1][0] = King.new([1,0], " ", :White, board)
      board.cell[2][0] = Queen.new([1,0], " ", :Black, board)

      expect(board.in_check?(:White)).to eq(true)
    end

    it 'should return false if that color is not in check' do
      expect(board.in_check?(:White)).to eq(false)
    end
  end

  describe "#find_king" do 
    it 'should find the black king in the initial position' do 
      expect(board.find_king(:Black)).to eq([0,4])
    end

    it 'should find the white king in the initial position' do 
      expect(board.find_king(:White)).to eq([7,4])
    end
  end

  describe '#off_board?' do 
    it 'should return true if the square is off the board' do 
      square = [10,10]
      expect(board.off_board?(square)).to eq(true)
    end

    it 'should return false if the square is on the board' do
      square = [0,0]
      expect(board.off_board?(square)).to eq(false)
    end
  end

  describe '#same_team_square?' do 
    it 'should return false if the square is empty' do 
      board.cell[1][0] = Queen.new([1,0], " ", :White, board)
      board.cell[2][0] = nil

      expect(board.same_team_square?([1,0],[2,0])).to eq(false)
    end

    it 'should return false if the to square team is different than the from square team' do
      board.cell[1][0] = Queen.new([1,0], " ", :White, board)
      board.cell[2][0] = Queen.new([1,0], " ", :Black, board)

      expect(board.same_team_square?([1,0], [2,0])).to eq(false)
    end

    it 'should return true if to square team is the same as the from square team' do
      board.cell[1][0] = Queen.new([1,0], " ", :White, board)
      board.cell[2][0] = Queen.new([1,0], " ", :White, board)

      expect(board.same_team_square?([1,0], [2,0])).to eq(true) 
    end
  end

end
