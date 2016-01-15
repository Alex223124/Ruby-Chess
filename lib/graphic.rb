require 'colorize'
require 'io/console'
class Graphic

  attr_accessor :show_cursor

  KEYMAP = {
    " " => :space,
    "\r" => :return,
    "\e[A" => :up,
    "\e[B" => :down,
    "\e[C" => :right,
    "\e[D" => :left,
    "\u0003" => :ctrl_c,
  }

  MOVES = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0]
  }

  def initialize(board)
    @board = board 
    @cursor_pos = [6,4]
    @show_cursor = @board.cell[@cursor_pos[0]][@cursor_pos[1]]
  end

  def get_inputs(turn)
    puts ""
    @color = turn
    @cursor_pos = @board.find_king(@color)
    display
    puts " "
    puts "#{@color} where would you like to move from?"
    from = get_input

    puts " "
    puts "#{@color} where would you like to move to?"
    to = get_input
    [from, to]
  end

  def get_input
    key = KEYMAP[read_char]
    handle_key(key).nil? ? get_input : @cursor_pos
  end

  def handle_key(key)
    case key
    when :ctrl_c
      exit 0
    when :return, :space
      @cursor_pos
    when :left, :right, :up, :down
      update_pos(MOVES[key])
      display
      nil
    else
      puts key
    end
  end

  def update_pos(diff)
    new_pos = [@cursor_pos[0] + diff[0], @cursor_pos[1] + diff[1]]
    @cursor_pos = new_pos unless @board.off_board?(new_pos)
  end

  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end

  ensure
    STDIN.echo = true
    STDIN.cooked!

    return input
  end

  def display
    puts "\e[H\e[2J"
    puts "#{@color}s turn" 
    puts "!!!!!!!! - #{@color} NEEDS TO GET OUT OF CHECK - !!!!!!!!!" if @board.in_check?(@color)

    @board.cell.each_with_index do |col, idx|
      puts ""
      col.each_with_index do |piece, idx_2|

        # square for the icon
        if idx == @cursor_pos[0] && idx_2 == @cursor_pos[1]
          if piece.nil?
            print "     ".colorize( :background => :light_blue, :color => :black)
          else
            if piece.color == :Black
              print piece.icon.colorize( :background => :light_blue, :color => :black)
            else
              print piece.icon.colorize( :background => :light_blue, :color => :white)
            end
          end

        # if the square is empty
        elsif piece.nil?
          if !@board.cell[@cursor_pos[0]][@cursor_pos[1]].nil? && @board.cell[@cursor_pos[0]][@cursor_pos[1]].moves.include?([idx, idx_2])
            if (idx + idx_2).even?
              print "     ".colorize(:background => :light_yellow, :color => :black)
            else
              print "     ".colorize(:background => :light_red, :color => :black)
            end
            next
          end

          if (idx + idx_2).even?
            print "     ".colorize( :background => :yellow, :color => :light_yellow)
          else
            print "     ".colorize( :background => :red, :color => :light_red)
          end

        # highlight possible captures
        elsif !@board.cell[@cursor_pos[0]][@cursor_pos[1]].nil? && @board.cell[@cursor_pos[0]][@cursor_pos[1]].moves.include?([idx, idx_2])
            if piece.color == :Black
              if (idx + idx_2).even?
                print "#{@board.cell[idx][idx_2].icon}".colorize(:background => :light_yellow, :color => :black)
              else
                print "#{@board.cell[idx][idx_2].icon}".colorize(:background => :light_red, :color => :black)
              end
            else
              if (idx + idx_2).even?
                print "#{@board.cell[idx][idx_2].icon}".colorize(:background => :light_yellow, :color => :white)
              else
                print "#{@board.cell[idx][idx_2].icon}".colorize(:background => :light_red, :color => :white)
              end
            end

        # occupied by a piece
        else
          if (idx + idx_2).even?
            if piece.color == :Black
              print piece.icon.colorize( :background => :yellow, :color => :black)
            else
              print piece.icon.colorize( :background => :yellow, :color => :white)
            end
          else
            if piece.color == :Black
              print piece.icon.colorize( :background => :red, :color => :black)
            else
              print piece.icon.colorize( :background => :red, :color => :white)
            end
          end
        end
      end
    end
    puts " "
    if !@board.cell[@cursor_pos[0]][@cursor_pos[1]].nil? 
      puts " "
      puts "Possible Moves: "
      puts "#{@board.cell[@cursor_pos[0]][@cursor_pos[1]].moves.length}"
      puts " "
    end
    ## For Debugging ##
    #   if @board.cell[@cursor_pos[0]][@cursor_pos[1]].class == Pawn
    #     puts "This piece has moved: #{@board.cell[@cursor_pos[0]][@cursor_pos[1]].has_moved}"
    #     puts "Is it a king? #{@board.cell[@cursor_pos[0]][@cursor_pos[1]].kinged_status}"
    #   end
    #   puts " "
    #   puts "Current Position: "
    #   puts "#{@board.cell[@cursor_pos[0]][@cursor_pos[1]].position}"      
    #   puts " "
    #   puts "Team: "
    #   puts "#{@board.cell[@cursor_pos[0]][@cursor_pos[1]].color}"      
    #   puts " "
    #   puts "Move Directions: "
    #   puts "#{@board.cell[@cursor_pos[0]][@cursor_pos[1]].move_directions}"      
    # else
    #   puts " "
    #   puts "Current Position: "
    #   puts "#{[@cursor_pos[0],@cursor_pos[1]]}" 
    # end
  end
end