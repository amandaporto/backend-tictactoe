require 'sinatra'
require 'json'

post '/game' do
player_1 = params["player_1_name"]
player_2 = params["player_2_name"]
end

post '/move' do
  current_player = params["player"]
  move = params["position"]
  if status == "ok"
  redirect '/game', 201
elsif status == "invalid"
  redirect '/game', 409

end
