class Deck < ApplicationItem

	SUITS = ["Hearts", "Clubs", "Diamonds", "Spades"]
	RANKS = ["Ace", "2", "3", "4", "5", "6" ,"7", "8", "9", "10", "Jack", "Queen", "King"]

	column :id, :cards

	def self.find_by_id(id)
		result = Deck.find(id)
		unless result.present?
			cards = Deck.shuffled
			result = Deck.new("id" => "#{id}", "cards" => cards)
			result.replace
			result = Deck.find(id)
		end
		return result
	end

	def shuffle
		self.cards = Deck.shuffled
		self.replace
		return nil
	end

	def dealOneCard
		card = cards.shift 
		self.replace
		return card
	end

	def self.shuffled

		cards = []
		for suit in SUITS
			for rank in RANKS
				cards << Card.new(rank,suit)
			end
		end

		#going to implement Fisher/Yates manually here
		rng = Random.new
		for c in 0..cards.size-2
			swap = rng.rand(c..cards.size-1)
			cards[swap], cards[c] = cards[c], cards[swap]
		end	

		return cards.collect{|item| item.to_hash}
	end

end
