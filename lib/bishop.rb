require_relative 'sliding_pieces'

class Bishop < SlidingPieces

  def move_directions
    { :ne    => [-1,1],
      :nw    => [-1,-1],
      :se    => [1,1],
      :sw    => [1,-1]
    }
  end
end
