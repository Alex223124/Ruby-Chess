require 'byebug'

class Board
  attr_reader :size
  attr_accessor :cell

  def initialize(size)
    @size = size
    @pawns       = ["  ♟  ", "  ♟  "]
    @kings       = ["  ♚  ", "  ♚  "]
    @queens      = ["  ♛  ", "  ♛  "]
    @bishops     = ["  ♝  ", "  ♝  "]
    @knights     = ["  ♞  ", "  ♞  "]
    @rooks       = ["  ♜  ", "  ♜  "]
    build_board
  end

  def move(from, to, colors_turn)
    piece = @cell[from[0]][from[1]]
    check_conditions(from, to, colors_turn, piece)
    piece.mark
    execute_move(from, to)
    promote(piece) if piece.kinged_status == true
  end

  def check_conditions(from, to, colors_turn, piece)
    if piece.nil?
      raise MoveError.new("Your intial square is not occupied")
    elsif piece.color != colors_turn
      raise MoveError.new("Its not that colors turn to move")
    elsif off_board?(to) || same_team_square?(from, to)
      raise MoveError.new("The square you are moving to is not legal")
    elsif !piece.moves.include?([to[0],to[1]])
      raise MoveError.new("That is not a valid move for the piece!")
    elsif piece.move_will_leave_in_check?(from, to, colors_turn)
      raise MoveError.new("THAT MOVE WILL LEAVE YOU IN CHECK")
    end
  end

  def promote(piece)
    position = piece.position
    color = piece.color
    self.cell[position[0]][position[1]] = nil
    self.cell[position[0]][position[1]] = Queen.new(position, @queens[1], color, self)
  end

  def execute_move(from, to)
    piece = @cell[from[0]][from[1]]

    @cell[to[0]][to[1]] = piece
    piece.position = [to[0],to[1]]
    @cell[from[0]][from[1]] = nil
  end

  def cant_get_out_of_check?(color)
    pieces(color).each do |piece|
      piece.moves.each do |move|
        if piece.move_will_leave_in_check?(piece.position, move, color) == false
          return false
        end
      end
    end
    true
  end

  def in_check?(color)
    pieces(other_team(color)).any? { |x| x.moves.include?(find_king(color))}
  end

  def pieces(team_color)
    self.cell.flatten.select { |x| !x.nil? && x.color == team_color }
  end

  def find_king(color)
    pieces(color).select { |x| x.class == King }.first.position
  end

  def other_team(color)
    color == :White ? :Black : :White
  end

  def same_team_square?(from, to)
    return false if @cell[to[0]][to[1]].nil?
    @cell[from[0]][from[1]].color != @cell[to[0]][to[1]].color ? false : true
  end

  def off_board?(to)
    to.any? { |x| x < 0 || x > 7 }
  end

  def build_board
    @cell = Array.new(@size) { Array.new(@size) }
    build_pawns
    build_other_pieces(King, @kings, [0,4], [7,4])
    build_other_pieces(Queen, @queens, [0,3], [7,3])
    build_other_pieces(Bishop, @bishops, [0,2], [7,2])
    build_other_pieces(Bishop, @bishops, [0,5], [7,5])
    build_other_pieces(Knight, @knights, [0,1], [7,1])
    build_other_pieces(Knight, @knights, [0,6], [7,6])
    build_other_pieces(Rook, @rooks, [0,0], [7,0])
    build_other_pieces(Rook, @rooks, [0,7], [7,7])
  end

  def build_other_pieces(piece, icon, black_pos, white_pos)
    @cell.each_with_index do |row, row_idx|
      row.each_with_index do |cell, col_idx|
        if row_idx == black_pos[0] && col_idx == black_pos[1]
          @cell[row_idx][col_idx] = piece.new(black_pos, icon[0], :Black, self)
        elsif row_idx == white_pos[0] && col_idx == white_pos[1]
          @cell[row_idx][col_idx] = piece.new(white_pos, icon[1], :White, self)
        end
      end
    end
  end

  def build_pawns
    @cell.each_with_index do |row, row_idx|
      row.each_with_index do |cell, col_idx|
        if row_idx == 1
          @cell[row_idx][col_idx] = Pawn.new([row_idx, col_idx], @pawns[0], :Black, self)
        elsif row_idx == 6
          @cell[row_idx][col_idx] = Pawn.new([row_idx, col_idx], @pawns[1], :White, self)
        end
      end
    end
  end
end