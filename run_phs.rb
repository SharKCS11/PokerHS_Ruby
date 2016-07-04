require_relative 'Card'

#Initialize a deck
DECK=Array.new;
(1..4).each do |s|
	(2..14).each do |r|
		DECK.push(Card.new(r,s));
	end
end

def printHand(set_of_cards,print_newline)
	print '[ ';
	set_of_cards.each do |c|
		print "#{c} ";
	end
	print "]";
	print "\n" if print_newline;
	$stdout.flush;
end

print "Deck is ";
printHand(DECK,true); print "\nNow trying randomization:\n";
$stdout.flush;

num_cards = 7; # number of cards you want to draw.


npairs=0;
draw=Array.new;
(0..51).to_a.shuffle.take(num_cards).each do |n|
	draw.push(DECK[n]);
end
print "You drew: ";
printHand(draw,true);
$stdout.flush;
npairs=HandTesting.countPairs(draw);
puts "  Number of pairs is #{npairs}";