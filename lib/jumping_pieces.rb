require_relative 'piece'

class JumpingPieces < Piece

  def valid_options(direction)
    directions = []
    exploring = [(self.position[0] + direction[0]), (self.position[1] + direction[1])]

    if takeable_spot?(exploring)
      directions << exploring
      exploring = [(exploring[0] + direction[0]), (exploring[1] + direction[1])]
    end
    
    directions
  end

end