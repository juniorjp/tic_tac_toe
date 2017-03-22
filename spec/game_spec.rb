require 'stringio'
require_relative '../game'

describe Game do

  it "should fill the board if the user input is valid" do
    $stdin = StringIO.new("3")
    game = Game.new
    game.get_human_spot
    board = game.instance_variable_get(:@board)
    $stdin = STDIN
    expect(board[3]).to eq('O')
  end
end
