require_relative 'jumping_pieces'

class Knight < JumpingPieces
  def move_directions
    { :north_east => [-2,1], 
      :north_west => [-2,-1],
      :east_north => [-1,2],
      :east_south => [1,2],
      :south_east => [2,1],
      :south_west => [2,-1],
      :west_north => [-1,-2],
      :west_south => [1,-2]
    }
  end
end