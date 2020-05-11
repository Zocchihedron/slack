class SlackController < ApplicationController
  skip_forgery_protection
  before_action :set_deck

  
  def post

  	case @command
  	when "shuffle"
  		@deck.shuffle
  		@result = "Shuffled!"
  	when "deal"
  		card = @deck.dealOneCard
  		@result = "#{card["rank"]} #{card["suit"]}"
  	end
  	render template: 'slack/post', layout: false
  end


  private

  def set_deck
  	#request_data = Rack::Utils.parse_nested_query(params["body"])
  	request_data = params
  	unique_deck_id = request_data["team_id"] + "::" + request_data["channel_id"] 
    @deck = Deck.find_by_id(unique_deck_id)
    @command = request_data["text"]
  end

end
