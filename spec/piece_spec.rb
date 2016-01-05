require 'rspec'
require 'piece'

describe "Piece" do 

  let(:piece) { Piece.new([1,0], "x", :Black, nil) }

  it "should read and write its position" do 
    expect(piece.position).to eq([1,0])
    piece.position = [2,0]
    expect(piece.position).to eq([2,0])
  end

  it "should only be allowed to read its color" do 
    expect(piece.color).to eq(:Black)
    expect { piece.color = :White }.to raise_error(NameError)
  end

  it "should only be allowed to read its icon" do 
    expect(piece.icon).to eq("x")
    expect { piece.icon = "o" }.to raise_error(NameError)
  end
end