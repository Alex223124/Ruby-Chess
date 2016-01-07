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