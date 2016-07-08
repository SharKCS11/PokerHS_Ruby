require_relative 'Card'

#Initialize a deck
DECK=Array.new;
(1..4).each do |s|
	(2..14).each do |r|
		DECK.push(Card.new(r,s));
	end
end


print "Deck is ";
printHand(DECK,true); print "\nNow trying randomization:\n";
$stdout.flush;

num_cards = 7; # number of cards you want to draw.

# Testing draw
npairs=0;
draw=Array.new;
(0..51).to_a.shuffle.take(num_cards).each do |n|
	draw.push(DECK[n]);
end
print "You drew: ";
printHand(draw,true);
npairs=HandTesting.countPairs(draw);
puts "  Number of pairs is #{npairs} \n";

print "Sorting by rank, we have\n  ";
draw.sort! {|x,y| x<=>y};
printHand(draw,true);
maxim=MaxFinder.new(draw);
maxim.printState;
puts "\n"; 



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