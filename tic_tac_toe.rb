require_relative 'player.rb'
require_relative 'computer.rb'

class Game
  attr_accessor :current_player, :count
  def initialize
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @current_player = current_player
    @count = 1
    @count = count



    def coin_toss
      if rand.round == 0
        @sym_1 = :x
        @sym_2 = :o
      else
        @sym_1 = :o
        @sym_2 = :x
      end
    end

    end


    def check_win(player)
      wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
      [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
      wins.each do |win|
          if win.all? { |positions| board.values[positions] == player }
            puts "#{player} wins"
            response[:board][:state] = "player #{player} wins"
          end
        end
      end
    end

    def play
      get_players
      until @count == 10 || @win == :y
        find_turn
        print_board
        @current_player.turn
        check_win(current_player)
        @count += 1
      end
      if @count == 10 && @win != :y
      puts 'tie'
    end
    end


  end
  def turn


      @count -= 1
    end

game = Game.new
game.play
