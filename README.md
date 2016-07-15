# Poker Hand Simulator: Ruby Rewrite
A clone of the original Poker Hand Simulator, rewritten in Ruby. A GUI is soon to-be-made using RubyFX or Shoes!

In a poker game, how many times on average do you need to draw a hand of cards before you finally get a straight flush? The Poker Hand Simulator was created as a statistical experiment to answer this question. There were a few bugs with the Javascript
version, so I've recoded the program in Ruby, which is an Object-Oriented language.

The Poker Hand Simulator draws n=7 cards (such as in Texas Hold'em) from a shuffled deck of 52. The program then determines the best 5-card hand from the draw. The value of 'n' can be changed in the file run_phs.rb next to the comment "number of cards you want to draw."
It does this repeatedly until it draws a straight flush, and tallies up the results. The program can only
be used from the command line right now, but a GUI overlay will come eventually.

<h3> How to Run </h3>
First, make sure you have Ruby installed (version 1.9 or later). Download the files from the repository and from command line,
run the simulator using
```
ruby run_phs.rb
```
*An executable of this ruby script will also be coming soon.*

<h3> Example of Default Simulator </h3>

Say the program draws a random hand [Qs, 3c, 9d, Qd, 5c, 10d, 2s]. It will determine that the best five-card hand will consist
of the pair of Queens, and the three highest kickers, being 10, 9, and 5. The output will be:
```
You drew:  [Qs, 3c, 9d, Qd, 5c, 10d, 2s]
  Best hand is 5c, 9d, 10d, Qs, Qd
Pair of Queens
```
Since the hand was not a straight flush, the program will continue drawing and identifying new hands until it does find one. In the end, it will tally the results as such:
```
Final hand strength tally is:
  High-Cards:  563
  Pairs:       1459
  Two-Pairs:   778
  Triples:     138
  Straights:   166
  Flushes:     102
  Full Houses: 93
  Quads:       3
  Straight Flushes: 1
  Total number of draws before hitting a straight flush = 3303 
```
Another interesting thing is that this program can be used to test if a random number generator isn't working as intended. The number of draws before hitting a straight flush will more or less follow a geometric distribution, with an expected value of approximately 3215. Repeated major deviations from this number may signify that something is wrong!

<h3> Future Development Plans </h3>
There are a few things remaining to be done. Firstly, an exe would probably be more convenient to run than the raw ruby source code,
so that's next on the list. After that, a GUI will be built (using [Ruby Shoes](http://shoesrb.com/) maybe?).

Finally, the algorithm that finds the best 7-card hand basically uses brute force. Since the major variants of poker use 7-12
cards, it didn't seem necessary to speed up the program that much. In addition, most high-value hands become quite common as you increase
the number of cards you draw.

This results in O(n-choose-5) computation time if you vary 'n'. So far, the program is working for up to n=21 in a reasonable amount of time.
In any case, I'll try to speed up this program using some kind of branch-and-bound method if I feel like it.

----------------------------------------------------------------------------------------------------------------------------

<h3> Poker Hand Rankings in Ascending Order </h3>

| Rank | Example |
|------|---------|
|High Card| [As, 3d, 5s, 10h, 8d] = Ace High|
|Pair| [As, Ac, 5s, 10h, 8c] = Pair of Aces|
|Two-Pair| [As, Ac, 5s, 5h, 8c] = Two Pair: Aces and Fives|
|Three of a Kind| [As, Ac, Ad, 5h, 8c] = Three of a Kind: Trip Aces|
|Straight| [7c, 8d, 9c, 10s, Jh] = Straight: Jack High|
|Flush| [2h, 5h, 6h, 10h, Jh] = Flush: Jack High|
|Full House| [As, Ac, Ad, 5h, 5c] = Full House: Aces over Fives|
|Four of a Kind| [Ks, Kh, Kd, Kc, 5h] = Four of A Kind: Quad Kings|
|Straight Flush| [7c, 8c, 9c, 10c, Jc] = Straight Flush: Jack High|
