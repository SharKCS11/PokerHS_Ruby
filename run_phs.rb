require_relative 'Card'

#Initialize a deck
DECK=Array.new;
(1..4).each do |s|
	(2..14).each do |r|
		DECK.push(Card.new(r,s));
	end
end


num_cards = 21; # number of cards you want to draw.

# Testing draw
final_hand_strength=-1;
hands_tally=Array.new(9,0);
until final_hand_strength>=8 do
	draw=Array.new;
	(0..51).to_a.shuffle.take(num_cards).each do |n|
		draw.push(DECK[n]);
	end
	print "You drew: ";
	printHand(draw,true);
	#testHand=[Card.new(13,3),Card.new(7,1),Card.new(6,1),Card.new(11,1),Card.new(3,4),Card.new(6,3),Card.new(14,1)];
	#print "Testing with "; printHand(testHand,true);
	maxim=MaxFinder.new(draw); 
	final_hand_strength=maxim.getMaxHand();
	hands_tally[final_hand_strength]+=1;
	puts "\n";
end
tally_sum=0;
hands_tally.each do |n|
	tally_sum+=n;
end
puts "Final hand strength tally is:";
puts ("  High-Cards:  #{hands_tally[0]}\n" + \
	 "  Pairs:       #{hands_tally[1]}\n" + \
	 "  Two-Pairs:   #{hands_tally[2]}\n" + \
	 "  Triples:     #{hands_tally[3]}\n" + \
	 "  Straights:   #{hands_tally[4]}\n" + \
	 "  Flushes:     #{hands_tally[5]}\n" + \
	 "  Full Houses: #{hands_tally[6]}\n" + \
	 "  Quads:       #{hands_tally[7]}\n" + \
	 "  Straight Flushes: #{hands_tally[8]}\n" + \
	 "  Total number of draws before hitting a straight flush = #{tally_sum} \n");




=begin #Testing hand_less
puts "Let's test hand heights now.";
testHand1=[Card.new(13,1),Card.new(13,2),Card.new(2,4),Card.new(2,1),Card.new(2,3)];
testHand2=[Card.new(5,1),Card.new(5,2),Card.new(8,4),Card.new(5,3),Card.new(8,1)];
testHand1.sort! {|x,y| x<=>y};
testHand2.sort! {|x,y| x<=>y};
print "  Testing with ";
printHand(testHand1,false); print "   "; printHand(testHand2,true);
puts "  Testing the less function #{HandTesting.hand_less(testHand2,testHand1)}";
=end

=begin #Testing ranks
print "Let's test the hand for strengths: ";
testHand=[Card.new(3,1),Card.new(3,2),Card.new(14,4),Card.new(3,3),Card.new(3,4)];
printHand(testHand,true);
stg=HandTesting.getStrength(testHand);
puts "Rank is #{stg} i.e. #{HandTesting.rank_names[stg]}";
=end

=begin  #testing straights and flushes?
# Testing straights
puts "Let's test a straight.";
testHand=DECK[0,4];
testHand.push(DECK[19]);
print "  We got "; printHand(testHand,true); $stdout.flush;
puts "  is it a straight? #{HandTesting.isStraight(testHand).to_s}";
puts "\n";

# Testing flushes
puts "Let's test a flush.";
testHand=DECK[30,5];
print "  We got "; printHand(testHand,true); $stdout.flush;
puts "  is it a flush? #{HandTesting.isFlush(testHand).to_s}";
=end