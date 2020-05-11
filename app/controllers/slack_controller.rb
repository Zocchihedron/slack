class SlackController < ApplicationController
  skip_forgery_protection
  before_action :set_deck

  
  def post

  	command = params[:command]

  	case command
  	when "/shuffle"
  		@deck.shuffle
  		@result = "Shuffled!"
  	when "/deal"
  		card = @deck.dealOneCard
  		@result = "#{card["rank"]} #{card["suit"]}"
  	end
  	render template: 'slack/post', layout: false
  end


  private

  def set_deck
  	unique_deck_id = params[:team_id] + "::" + params[:channel_id] 
    @deck = Deck.find_by_id(unique_deck_id)
  end

end
