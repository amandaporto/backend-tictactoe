require 'sinatra'
require 'json'
require 'sinatra/reloader' if development?

post '/game' do
  player_1 = params["player_1_name"]
  player_2 = params["player_2_name"]
end

post '/move' do
  current_player = params["player"]
  move = params["position"]
  if status == "ok"
  status 201
  elsif status == "invalid"
  status 409
  end
end
