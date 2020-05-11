class Card

	def initialize(rank, suit)
		@rank = rank
		@suit = suit
	end

	def rank
		@rank
	end

	def suit
		@suit
	end

	def to_hash
    	hash = {}
    	instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    	hash
  end
end
