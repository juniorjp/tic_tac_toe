class InputService

  attr_accessor :spot
  attr_accessor :board
  def initialize(board)
    @board = board
  end

  def get_valid_spot!
    @spot = gets.chomp
    until check_valid_spot!
      puts "Please, type a valid location\n"
      @spot = gets.chomp
    end
    @spot = @spot.to_i
    @spot
  end

  def check_valid_spot!
    @spot.is_integer? && is_valid_position?
  end

  private

  def is_valid_position?
    candidate_spot = @spot.to_i
    candidate_spot >= 0 && candidate_spot <= 9 && @board[candidate_spot] != "X" && @board[candidate_spot] != "O"
  end

end
