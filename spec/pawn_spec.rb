require 'rspec'
require 'pawn'
require 'board'
require 'bishop'
require 'jumping_pieces'
require 'king'
require 'knight'
require 'pawn'
require 'piece'
require 'queen'
require 'rook'
require 'sliding_pieces'
require 'graphic'

describe "Pawn" do
  let(:board) { Board.new(8) }
  let(:white_pawn) { Pawn.new([6,0], " ", :White, board) } 
  let(:black_pawn) { Pawn.new([1,0], " ", :Black, board) }

  it "should only be able to move diagonally if capturing the other team" do 
    pawn = Pawn.new([5,4], " ", :Black, board)

    expect(pawn.moves).to contain_exactly([6,3],[6,5])
  end

  it "should not be able to attack pieces in front of it" do
    pawn = Pawn.new([5,4], " ", :Black, board)
    pawn.mark
    expect(pawn.moves).to_not include([6,4])
  end

  it "should not be able to move backwards" do
    pawn = Pawn.new([4,4], " ", :Black, board)
    pawn.mark
    expect(pawn.moves).to contain_exactly([5,4])
  end


  context "before it has moved" do 
    it "has_moved instance variable should be initialized as false" do
      expect(black_pawn.has_moved).to be false
      expect(white_pawn.has_moved).to be false
    end

    it "can move two spaces forward" do
      expect(white_pawn.moves).to include([4,0])
      expect(black_pawn.moves).to include([3,0])
    end
  end

  context "after it has moved" do
    it "after a pawn moves #has_moved should equal true" do
      black_pawn.mark
      white_pawn.mark

      expect(black_pawn.has_moved).to be true
      expect(white_pawn.has_moved).to be true
    end

    it "should not be allowed to move two spaces forward" do
      black_pawn.mark
      white_pawn.mark

      expect(black_pawn.moves).to_not include([3,0])
      expect(black_pawn.moves).to_not include([4,0])
    end
  end
end