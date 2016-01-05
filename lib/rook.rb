require_relative 'sliding_pieces'

class Rook < SlidingPieces

  def move_directions
    { :up    => [-1,0], 
      :down  => [1,0],
      :left  => [0,-1],
      :right => [0,1],
    }
  end
end