require 'stringio'

class GameModeService

  def initialize()
  end

  def get_valid_mode!
    puts "Choose degree of difficulty  \n Type 1(Hard) or 2(Easy)".colorize(:green)
    @mode = $stdin.gets.chomp
    until check_valid_mode!
      puts "Please, type a valid mode\n".colorize(:red)
      @mode = $stdin.gets.chomp
    end
    @mode = @mode.to_i
    puts "Starting in #{@mode == 1 ? 'Hard' : 'Easy'} mode".colorize(:magenta)
    @mode
  end

  def check_valid_mode!
    @mode.is_integer? && is_valid_mode?
  end

  private

  def is_valid_mode?
    candidate_mode = @mode.to_i
    candidate_mode == 1 || candidate_mode == 2
  end

end
