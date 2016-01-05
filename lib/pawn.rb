require_relative 'piece'

class Pawn < Piece
  attr_accessor :unique_moves

  def initialize(coords, icon, team, board)
    super(coords, icon, team, board)
  end

  def move_directions
    @unique_moves = {}
    get_moves
    @unique_moves
  end

  def kinged_status
    if self.color == :Black && self.position[0] == 7
      return true
    elsif self.color == :White && self.position[0] == 0
      return true
    end
    false
  end

  def get_moves
    black_forward if self.color == :Black
    white_forward if self.color == :White
    initial_move
    check_diagonals_for_capture
  end

  def black_forward
    if self.board.cell[(self.position[0])+1][self.position[1]] == nil
      @unique_moves[:down] = [1,0]
    end
  end

  def white_forward
    if self.board.cell[(self.position[0])-1][self.position[1]] == nil
      @unique_moves[:up] = [-1,0]
    end
  end

  def initial_move
    return nil if self.has_moved

    if self.color == :Black
      if self.board.cell[(self.position[0])+2][self.position[1]] == nil
        @unique_moves[:down_2] = [2,0]
      end
    else
      if self.board.cell[(self.position[0])-2][self.position[1]] == nil
        @unique_moves[:up_2] = [-2,0]
      end
    end
  end

  def check_diagonals_for_capture
    black_diagonals = [[1,1], [1,-1]]
    white_diagonals = [[-1,1], [-1,-1]]

    se_square = self.board.cell[self.position[0] + black_diagonals[0][0]][self.position[1] + black_diagonals[0][1]]
    sw_square = self.board.cell[self.position[0] + black_diagonals[1][0]][self.position[1] + black_diagonals[1][1]]

    ne_square = self.board.cell[self.position[0] + white_diagonals[0][0]][self.position[1] + white_diagonals[0][1]]
    nw_square = self.board.cell[self.position[0] + white_diagonals[1][0]][self.position[1] + white_diagonals[1][1]]

    if self.color == :Black
      if !se_square.nil? && se_square.color == :White
        @unique_moves[:se] = [1,1]
      end
      
      if !sw_square.nil? && sw_square.color == :White
        @unique_moves[:sw] = [1,-1]
      end
    else
      if !ne_square.nil? && ne_square.color == :Black 
        @unique_moves[:ne] = [-1,1]
      end

      if !nw_square.nil? && nw_square.color == :Black
        @unique_moves[:nw] = [-1,-1]
      end
    end
  end

  def valid_options(direction)
    directions = []
    exploring = [(self.position[0] + direction[0]), (self.position[1] + direction[1])]

    if takeable_spot?(exploring)
      directions << exploring
      exploring = [(exploring[0] + direction[0]), (exploring[1] + direction[1])]
    end

    directions
  end

  def takeable_spot?(spot)
    return false if @board.off_board?(spot)
    if !@board.cell[spot[0]][spot[1]].nil? && @board.cell[spot[0]][spot[1]].color == self.color
      return false
    end

    true
  end

end
