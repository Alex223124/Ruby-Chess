## Ruby-Chess
Command Line Chess Written in Ruby

### Logic
* Piece.rb is the parent class to all piece Objects.
* Each instance of Piece holds a reference to the Board class.
* There are three child classes to Piece, SlidingPieces, JumpingPieces, and Pawns
* SlidingPieces include: Queens, Bishops, and Rooks
* JumpingPieces include: Kings and Knights
* E.g. Knight < JumpingPiece < Piece
* Pawns inherit directly from Piece
* E.g. Pawn < Piece

### Classes
* Piece - Holds logic all pieces share. Every piece can move on the board and we use the instance method #moves to find all of the moves for a particular piece. The #move_directions method is polymorphic. Each piece can move in slightly different directions I stored those directions in a hash, see below.

```ruby
  def moves
    possible_moves = []
    self.move_directions.each do |key, value|
      possible_moves << valid_options(value)
    end

    possible_moves.flatten(1)
  end
```
Each piece will have its own move_directions method.

```ruby
# Rook < SlidingPieces
  def move_directions
    { :up    => [-1,0], 
      :down  => [1,0],
      :left  => [0,-1],
      :right => [0,1],
    }
  end
```

* Board - The board class is responsible for building the board upon game initialization and moving the pieces. The #move method is the most important method of the class. To move a piece you must first locate the piece on the board and store it in the variable piece. Then we make sure the its a valid move, if the move is valid we mark the piece as moved and change the state of the board. Lastly we check to see if the piece can be promoted.

```ruby
  def move(from, to, colors_turn)
    piece = @cell[from[0]][from[1]]
    check_conditions(from, to, colors_turn, piece)
    piece.mark
    execute_move(from, to)
    promote(piece) if piece.kinged_status == true
  end
```

* Graphic - The graphic class is not very interesting. Its responsible for creating the graphics in the terminal. Since we use a the arrow keys to capture a users move selection, we must re-render the entire board each time the user pushes an arrow key. This needs the most amount of refactoring because the rendering can be slow if the user pushes the keys too fast. However, I think the much simpler UI is worth the slower rendering. In chess people spend most of their time thinking and very little time actually moving pieces around. For this reason I think the slower rendering is worth it for a better UI.

* SlidingPieces & JumpingPieces - These classes are similar in a lot of ways. The only difference is that a sliding pieces travel distance can change depending on the state of the board. What I mean by that is a Queen (SlidingPiece) can travel the entire length of the board if her path is unobstructed. However, a King (JumpingPiece), is limited in the number of squares he can travel in the x and y directions. Kings can only move 1 space in all directions if unobstructed. So the SlidingPieces utilizes a while loop to continue accumulating possible moves, while the JumpingPieces class uses the predetermined moves that are held by each piece, like the Rook example above.

* Pawns - Pawns are a bit different of a piece, so they do not inherit from SlidingPiece or JumpingPiece. This is because a pawn has a few special rules. They can only attack if the enemy is in a diagonal in-front of them. They can be "promoted" if they reach they other side of the board. Lastly pawns can move two spaces forward for the intial move but once they are moved they can only move 1 space forward. 


### Features
* Arrow Keys for Move input
* Colorized UI
* Shows Available Moves
* Warns player when they're in check
* RSpec for test coverage
* Object Oriented Design Features: Inheritance and Polymorphism


![Chess Screenshot](https://cloud.githubusercontent.com/assets/1512282/12153051/b07bbd18-b46c-11e5-8478-368fda6b21af.png)


### Up and running
* gem install 'colorize'
* ruby lib/game.rb