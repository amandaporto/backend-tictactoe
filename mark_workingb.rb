class Game

  def initialize
    @response = {
      "status": "ok",
      "board": { "state": "playing",
        "positions": {  "0": " ",
                        "1": " ",
                        "2": " ",
                        "3": " ",
                        "4": " ",
                        "5": " ",
                        "6": " ",
                        "7": " ",
                        "8": " "
        }
      }
    }

    @board = @response[:board][:positions]
  end


  def move(move, player)
    if @response[:board][:positions][move] == " "
      @response[:board][:positions][move] = player
    else
      content  = @response[:board][:positions][move]
      @response[:status] = "invalid"
      @response[:reason] = "Already an #{content} at this space"
    end
  end

  def check_win(player)
    wins = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]

    wins.each do |win|
      if win.all? { |positions| @board.values[positions] == player }
        puts "#{player} wins"
        @response[:board][:state] = "player #{player} wins"
      end
    end
  end


  if response[:board][:state] == "playing" && count == 10
    response[:board][:state] = "tie"
  end

end
