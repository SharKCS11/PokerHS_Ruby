# define class Card
=begin
	Card suits are:
	 1- clubs
	 2- diamonds
	 3- hearts
	 4- spades	 
=end 
	
class Card
	@@strRanks=['2','3','4','5','6','7','8','9', \
					'10','J','Q','K','A'];
	@@longRankStr=["Deuce","Three","Four","Five","Six","Seven","Eight","Nine",\
					"Ten","Jack","Queen","King","Ace"];
	@@shortStrSuits=['x','c','d','h','s'];
	@@longStrSuits=['NULL_SUIT','Clubs','Diamonds','Hearts','Spades'];

	attr_reader :rank,:suit

	def initialize(rank_in=2,suit_in=1)
		@suit=suit_in;
		@rank=rank_in;
	end

	def to_longStr
		rkstr=@@longRankStr[@rank-2];
		ststr=@@longStrSuits[@suit];
		return (rkstr + " of " + ststr);
	end

	def self.plur_s(x)
		if x!=6 and x!=1
			pluralRank=@@longRankStr[x-2];
			pluralRank += 's';
		end
	end

	def to_s
		rkstr=@@strRanks[@rank-2];
		ststr=@@shortStrSuits[@suit];
		return (rkstr+ststr);
	end
end

class HandTesting
	# relates to [2,3,4,5, 6, 7, 8, 9,10, J, Q, K, A]
	@@primes=[0,0,2,3,5,7,11,13,17,19,23,29,31,37,41]
	@@straightProducts=[2310,15015,85085,323323,1062347,2800733,6678671,14535931,31367009,8610]

	def self.countPairs(hand) # hand should contain five cards
		pairs=0;
		for i in (0..hand.size-2)
			for j in (i+1..hand.size-1)
				pairs+=1 if hand[i].rank==hand[j].rank;
			end
		end
		return pairs;
	end

	def self.isStraight(hand)
		prime_conversion_product=1;
		hand.each do |c|
			prime_conversion_product*=@@primes[c.rank];
		end
		return true if @@straightProducts.include?(prime_conversion_product)
	 	return false;
	end

	def self.isFlush(hand)
		first_suit=hand[0].suit;
		for j in (1..hand.size-1)
			return false if hand[j].suit!=first_suit;
		end
		return true;
	end

end