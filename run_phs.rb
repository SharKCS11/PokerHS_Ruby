require_relative 'Card'

#Initialize a deck
DECK=Array.new;
(1..4).each do |s|
	(2..14).each do |r|
		DECK.push(Card.new(r,s));
	end
end

puts DECK;

puts "\n\n";

card1=Card.new(11,4);
puts card1;
puts "Card1 is #{card1.to_longStr}";
puts "Card1 rank is #{card1.rank} and suit is #{card1.suit}";
card2=Card.new;
puts "\n" + card2.to_s;
puts "Second card rank is #{card2.rank} and suit is #{card2.suit}";