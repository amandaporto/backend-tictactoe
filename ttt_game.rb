require 'sinatra'
require 'json'
require 'sinatra/reloader' if development?


class Game
  attr_accessor :positions

  def initialize
    @turns = 0
    self.positions = [" ", " ", " ",
                      " ", " ", " ",
                      " ", " ", " "]
  end

  def status(move)
    @occupied_position = self.positions[move]
    if self.positions[move] == "O" || self.positions[move] == "X"
      "invalid"
    end
  end


  def move(move, player)
    if self.positions[move] != "O" && self.positions[move] != "X"
      self.positions[move] = player
      @turns += 1
    end
  end


    def state(player)
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

      if wins.any? do |win|
        win.all? { |position| self.positions[position] == player}
        end
        "Player #{player} wins"
      elsif @turns == 9
        "Tie"
      else
        "Playing"
      end
    end

end

configure do
  set :board, Game.new
end

post "/game" do
  headers "Access-Control-Allow-Origin" => "*"

  player_X = params[:player_X_name]
  player_O = params[:player_O_name]

  board = Game.new
  settings.board = board

  results = {
    "status" => "ok",
    "board" => {
      "state" => "playing",
      "position" => {
        "0": board.positions[0],
        "1": board.positions[1],
        "2": board.positions[2],
        "3": board.positions[3],
        "4": board.positions[4],
        "5": board.positions[5],
        "6": board.positions[6],
        "7": board.positions[7],
        "8": board.positions[8],
      }
    }
  }
  status 200
  results.to_json
end

post "/move" do
  headers "Access-Control-Allow-Origin" => "*"

  player = params[:player]
  move = params[:positions].to_i

  board = settings.board

  if board.status(move) == "invalid"
    results = {
      "status" => "invalid",
      "reason" => "already an #{@occupied_position} in this space",
      "board" => {
        "state" => board.state(player),
        "position" => {
          "0": board.positions[0],
          "1": board.positions[1],
          "2": board.positions[2],
          "3": board.positions[3],
          "4": board.positions[4],
          "5": board.positions[5],
          "6": board.positions[6],
          "7": board.positions[7],
          "8": board.positions[8],
        }
      }
    }
    status 409
  else
    board.move(move, player)
    results = {
      "status" => "ok",
      "board" => {
        "state" => board.state(player),
        "position" => {
          "0": board.positions[0],
          "1": board.positions[1],
          "2": board.positions[2],
          "3": board.positions[3],
          "4": board.positions[4],
          "5": board.positions[5],
          "6": board.positions[6],
          "7": board.positions[7],
          "8": board.positions[8],
        }
      }
    }
    status 200
  end

  results.to_json

end
