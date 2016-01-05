require_relative 'sliding_pieces'

class Queen < SlidingPieces

  def move_directions
    { 
      :left  => [0,-1],
      :right => [0,1],
      :ne    => [-1,1],
      :nw    => [-1,-1],
      :se    => [1,1],
      :sw    => [1,-1],
      :down  => [1,0],
      :up    => [-1,0], 
    }
  end
end