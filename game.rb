require_relative 'services/spot_service'
require_relative 'services/game_mode_service'
require_relative 'helper/string_helper'
require 'colorize'

class Game
  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @com = "X" # the computer's marker
    @hum = "O" # the user's marker
  end

  def start_game
    # start by asking for the game mode
    choose_mode()
    # print the board
    print_board()
    puts "Enter [0-8]:"
    # loop through until the game was won or tied
    until game_is_over(@board) || tie(@board)
      get_human_spot
      if !game_is_over(@board) && !tie(@board)
        eval_board
      end
      print_board()
    end
    puts "Game over"
  end

  def get_human_spot
    spot = SpotService.new(@board).get_valid_spot!
    @board[spot] = @hum
  end

  def eval_board
    spot = nil
    until spot
      if @board[4] == "4"
        spot = 4
        @board[spot] = @com
      else
        spot = get_next_move(@board, @com)
        if @board[spot] != "X" && @board[spot] != "O"
          @board[spot] = @com
        else
          spot = nil
        end
      end
    end
  end

  def get_next_move(board, com)
    if @mode == 1 #hard
      get_best_move(board, com)
    else
      get_random_move()
    end
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    best_move = nil
    available_spaces = get_available_spaces
    available_spaces.each do |as|
      board[as.to_i] = @com
      if game_is_over(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @hum
        if game_is_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
        end
      end
    end
    if best_move
      return best_move
    else
      get_random_space(available_spaces)
    end
  end

  def get_random_move()
    available_spaces = get_available_spaces
    get_random_space(available_spaces)
  end

  def game_is_over(b)

    [b[0], b[1], b[2]].uniq.length == 1 ||
    [b[3], b[4], b[5]].uniq.length == 1 ||
    [b[6], b[7], b[8]].uniq.length == 1 ||
    [b[0], b[3], b[6]].uniq.length == 1 ||
    [b[1], b[4], b[7]].uniq.length == 1 ||
    [b[2], b[5], b[8]].uniq.length == 1 ||
    [b[0], b[4], b[8]].uniq.length == 1 ||
    [b[2], b[4], b[6]].uniq.length == 1
  end

  def tie(b)
    b.all? { |s| s == "X" || s == "O" }
  end

  private

  def get_available_spaces
    available_spaces = []
    @board.each do |s|
      if s != "X" && s != "O"
        available_spaces << s
      end
    end
    available_spaces
  end

  def get_random_space(available_spaces)
    n = rand(0..available_spaces.count)
    return available_spaces[n].to_i
  end

  def print_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} \n===+===+===\n #{@board[3]} | #{@board[4]} | #{@board[5]} \n===+===+===\n #{@board[6]} | #{@board[7]} | #{@board[8]} \n".colorize(:light_blue)
  end

  def choose_mode
    @mode = GameModeService.new.get_valid_mode!
  end

end
