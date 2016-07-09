# define class Card
=begin
	Card suits are:
	 1- clubs
	 2- diamonds
	 3- hearts
	 4- spades	 
=end 

def assert(some_bool)
	exit(1) if !some_bool
end

class Card
	include Comparable

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

	def self.longRankStr
		@@longRankStr
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
		return pluralRank;
	end

	def <=>(other)
		self.rank<=>other.rank
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
	@@rank_names=["High","Pair","Two Pair","Three of a Kind","Straight","Flush","Full House","Four of a Kind",\
				  "Straight Flush"];

	def self.rank_names
		@@rank_names
	end

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

	def self.getStrength(hand)
		assert(hand.size==5);
		straight_bool=self.isStraight(hand);
		flush_bool=self.isFlush(hand);
		if(straight_bool && flush_bool) # straight flush
			return 8;
		end
		pairs=self.countPairs(hand)
		if pairs==6 # four-of-a-kind
			return 7;
		elsif pairs==4 # full house
			return 6;
		elsif flush_bool # flush
			return 5;
		elsif straight_bool # straight
			return 4;
		else
			return pairs;
		end
	end

	def self.sumRanks(hand)
		sum=0;
		hand.each do |cd|
			sum += cd.rank;
		end
		return sum;
	end

	def self.hand_less(lhs,rhs)
		lhs_str=self.getStrength(lhs);
		rhs_str=self.getStrength(rhs);
		if(lhs_str < rhs_str)
			return true;
		elsif(lhs_str > rhs_str)
			return false;
		end
		#code will continue if the strengths are equal
		if(lhs_str==0 || lhs_str==1 || lhs_str==3 || lhs_str==4 \
			|| lhs_str==5 || lhs_str==7 || lhs_str==8)
			lhs_height=MaxFinder.getHandHeight(lhs,lhs_str);
			rhs_height=MaxFinder.getHandHeight(rhs,rhs_str);
			if lhs_height<rhs_height
				return true;
			elsif lhs_height > rhs_height
				return false;
			end
		elsif(lhs_str==2 or lhs_str==6) #two-pair or full house
			lhs_height=MaxFinder.getHandHeight(lhs,lhs_str);
			rhs_height=MaxFinder.getHandHeight(rhs,rhs_str);
			if lhs_height[0]<rhs_height[0]
				return true;
			elsif lhs_height[0]>rhs_height[0]
				return false;
			elsif lhs_height[1]<rhs_height[1]
				return true;
			elsif lhs_height[1]>rhs_height[1]
				return false;
			end
		end
		#Both strengths and heights are equal: now we want kickers.
		return (self.sumRanks(lhs) < self.sumRanks(rhs));
	end

end

#Hand printing function
def printHand(set_of_cards,print_newline)
	print '[ ';
	set_of_cards.each do |c|
		print "#{c} ";
	end
	print "]";
	print "\n" if print_newline;
	$stdout.flush;
end

class MaxFinder # used to find the best 5 cards from a draw
	attr_reader :allhands,:hand_info_string, :best_strength

	def initialize(draw)
		draw.sort! {|x,y| x<=>y};
		@allhands=draw.combination(5).to_a;
		@hand_info_string="NULL_INFO_STRING";
	end

	def printState
		puts "Possible combinations are:";
		allhands.each do |hd|
			print "  ";
			printHand(hd,true);
		end
	end

	def self.findIndepKicker(hand) #hand must be of five cards in SORTED order.
		return hand[4].rank;
	end

	def self.countNextMatches(hand,idx)
		hits=0;
		key=hand[idx].rank;
		for j in (idx+1..hand.size-1)
			hits+=1 if hand[j].rank==key;
		end
		return hits;
	end

	def self.getHandHeight(hand,strength)
		if ([0,4,5,8].include?(strength)) # high-cards, straights, flushes
			return findIndepKicker(hand);
		elsif strength==1 # pair
			j=0;
			until (countNextMatches(hand,j) > 0)
				j+=1;
			end
			return hand[j].rank;
		elsif strength==2 # two pair
			j=0;
			until (countNextMatches(hand,j) > 0)
				j+=1;
			end
			first_pair=hand[j].rank;
			j=1;
			second_pair=0;
			num_matches=0;
			loop do
				num_matches=countNextMatches(hand,j) if(hand[j].rank!=first_pair);
				if num_matches>0
					second_pair=hand[j].rank;
					break;
				end
				j+=1;
			end
			if first_pair >= second_pair
				return [first_pair,second_pair];
			else
				return [second_pair,first_pair];
			end
		elsif strength==3 # trips
			j=0;
			until (countNextMatches(hand,j) > 0)
				j+=1;
			end
			return hand[j].rank
		elsif strength==6 # full house
			j=0;
			until (countNextMatches(hand,j) == 2)
				j+=1;
			end
			triple=hand[j].rank;
			j=1;
			double=0;
			num_matches=0;
			loop do
				num_matches=countNextMatches(hand,j) if(hand[j].rank!=triple);
				if num_matches>0
					double=hand[j].rank;
					break;
				end
				j+=1;
			end
			return [triple,double];
		elsif strength==7 # quads
			j=0;
			until (countNextMatches(hand,j) > 0)
				j+=1;
			end
			return hand[j].rank;
		end
	end

	def createInfoString(hand)
		strength=HandTesting.getStrength(hand);
		@best_strength=strength;
		height=MaxFinder.getHandHeight(hand,strength);
		if strength==0 # high card
			@hand_info_string = Card.longRankStr[height-2] + " High";
		elsif strength==1 # pair
			@hand_info_string = "Pair of " + Card.plur_s(height);
		elsif strength==2 # two-pair
			@hand_info_string = "Two-Pair: " + Card.plur_s(height[0]) + " and " + Card.plur_s(height[1]);
		elsif strength==3 # Triple
			@hand_info_string = "Three of a Kind: Trip " + Card.plur_s(height);
		elsif strength==4 # Straight
			@hand_info_string = "Straight: " + Card.longRankStr[height-2] + " High";
		elsif strength==5 # Flush
			@hand_info_string = "Flush: " + Card.longRankStr[height-2] + " High";
		elsif strength==6 # Full House
			@hand_info_string = "Full House: " + Card.plur_s(height[0]) + " over " + Card.plur_s(height[1]);
		elsif strength==7 # Quadruple
			@hand_info_string = "Four of a Kind: Quad " + Card.plur_s(height);
		elsif strength==8 # Straight Flush
			@hand_info_string = "Straight Flush: " + Card.longRankStr[height-2] + " High";
		end
	end

	def getMaxHand()
		curMaxIdx=0;
		for j in (0..@allhands.size-1)
			curMaxIdx = j if HandTesting.hand_less(@allhands[curMaxIdx],@allhands[j]) # max is less than new
		end
		besthand=@allhands[curMaxIdx];
		createInfoString(besthand);
		print "  Best hand is ";
		k=0;
		loop do
			print besthand[k]
			break if(k>=besthand.size-1)
			k+=1;
			print ", ";
		end
		print "\n";
		$stdout.flush;
		puts @hand_info_string;
		return best_strength;
	end
end
