require 'pry'

class TicTacToe

  WIN_COMBINATIONS =[
    [0,1,2],[3,4,5],[6,7,8], #horizontal
  [0,3,6],[1,4,7],[2,5,8], #vertical
  [0,4,8],[6,4,2] #diagonal
  ]

  #DISPLAYBOARD
  #0 1 2
  #3 4 5
  #6 7 8

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(position)
    input = position.to_i - 1
  end

  def move(index, token)
    @board[index] = token
  end

  def position_taken?(index)
    @board[index] != " "
  end

  def valid_move?(index)
    !position_taken?(index) && index.between?(0,8)
  end

  def turn_count
    @board.count{|space| space != " "}
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

   def turn
     puts "Choose a position (1-9): "
     user_input = gets.strip
     index = self.input_to_index(user_input)
    if self.valid_move?(index)
      token = self.current_player
      self.move(index, token)
    else
      self.turn
    end
    self.display_board
   end

   def won?
    WIN_COMBINATIONS.any? do |combination|
      if position_taken?(combination[0]) && @board[combination[0]] == @board[combination[1]] && @board[combination[1]] == @board[combination[2]]
        return combination
      end
    end
  end

  def full?
    @board.all? {|space| space != " "}
  end

  def draw?
    # if !full? && !won?
    #   false
    # elsif won?
    #   false
    # else
    #   true
    # end
    full? && !won?
  end

  def over?
    full? || won?
  end

  def winner
    if combination = won?
      @board[combination[0]]
    end
  end

  def play
    self.turn until self.over?
    if self.winner
      puts "Congratulations #{self.winner}!"
    else
      puts "Cat's Game"
    end
  end

end
