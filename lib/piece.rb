class Piece

  attr_accessor :position
  attr_reader :color, :board, :icon

  def initialize(position, icon, color, board)
    @color = color
    @position = position
    @icon = icon
    @board = board
  end

  def mark
    nil
  end

  def move_will_leave_in_check?(from, to, colors_turn)
    response = false
    to_piece = self.board.cell[to[0]][to[1]]
    from_piece = self.board.cell[from[0]][from[1]]

    self.board.cell[to[0]][to[1]] = self
    self.board.cell[to[0]][to[1]].position = to
    self.board.cell[from[0]][from[1]] = nil

    if self.board.in_check?(self.color)
      response = true
    end
    
    self.board.cell[to[0]][to[1]] = to_piece
    self.board.cell[from[0]][from[1]] = from_piece
    self.board.cell[from[0]][from[1]].position = from

    response
  end

  def moves
    possible_moves = []
    self.move_directions.each do |key, value|
      possible_moves << valid_options(value)
    end

    possible_moves.flatten(1)
  end

  def takeable_spot?(spot)
    return true  if spot == self.position
    return false if @board.off_board?(spot)
    return true  if @board.cell[spot[0]][spot[1]].nil?
    return false if @board.cell[spot[0]][spot[1]].color == self.color
    return true if @board.cell[spot[0]][spot[1]].color != self.color
  end

  def enemy_occupied_spot?(spot)
    return false if @board.cell[spot[0]][spot[1]].nil?
    return true if @board.cell[spot[0]][spot[1]].color != self.color
  end
end
