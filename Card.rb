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