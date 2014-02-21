get '/round/card/:card_id' do
  @card = Card.find(params[:card_id])
  erb :run_card
end

post '/card/answer/:card_id' do
  @guess = Guess.create
  if session[:cards].empty?
    redirect '/round/stats'
  else
    redirect "/round/card/#{session[:cards].pop.id}"
  end
end

get '/round/stats' do
  erb :stats
end

get '/round/:deck_id' do
  @deck = Deck.find(params[:deck_id])
  @round = Round.create(deck_id: params[:deck_id], user_id: session[:user_id])
  session[:round_id] = @round.id
  session[:cards] = @deck.cards.shuffle
  session[:deck_title] =@deck.title
  # binding.pry
  erb :start_round
end


## card answer final redirects to view stats

## post card/answer and card/answer/final up the counter in guess
## for correct answers and do nothing for incorrect answers.
