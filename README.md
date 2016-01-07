## Ruby-Chess
Command Line Chess Written in Ruby

### Logic
* Piece.rb is the parent class to all piece Objects.
* Each piece holds a reference to an instance of the Board class.
* There are three kinds of pieces, SlidingPieces, JumpingPieces, and Pawns
* SlidingPieces inherit from Piece and includes: Queens, Bishops, and Rooks
* JumpingPiees inherit from Piece include: Kings and Knights
* Pawns inherit directly from Piece


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