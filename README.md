# ishido
AHK version of game Ishido

From the original manual (slightly adapted):
-------------------------------------------

WELCOME TO ISHIDO  
  
From the first move this ancient game and beautiful puzzle will call upon  
your deepest powers of strategy and concentration as you match 72 stones on
a board of 96 squares.  
  
You can play for points or kick back and meditate over each move with the
deliberation of a Master.  See if you can outdo your own best score in
progressive games, and learn the secret of 4-Ways.  

  
As your strategy improves you will have a chance to discover what's at the 
heart of Ishido and why, to some, The Way of Stones is far more than a
game.  


OVERVIEW

Ishido is a board game where you attempt to match stones according to their
colors and patterns.  This ahk version of Ishido only can be played as a
solitaire game. 


THE GAME BOARD  
   
      *  The Game Board is eight squares high by 12 squares wide.  
  
      *  Stones come in sets of 72 stones.  Each stone has two attributes:
         A color/pattern and a symbol.  There are six symbols and six
         colors/patterns in each stoneset, thus creating 36 unique stones. 
         Each stone comes in a pair, hence 72 stones in each stoneset.  
  
      *  The Within consists of the interior squares.  
  
      *  The Beyond consists of the squares at the outer edges of the 
         board.  
  
      *  The Touchstone displays the next stone to be played.  
  
      *  The Scoreboard shows both the number of points scored, and the number
	     of 4-Way matches achieved.  
  
      *  The Pouch shows a representation of the number of stones remaining
         to play.
		 

BEGINNING PLAY  
  
Now that you're familiar with the board, it's time to cast the first stone.
The game begins with a unique Opening Tableau of six stones on the board and
a pouch of randomly ordered stones.  The Opening Tableau consists of stones
placed at each of the four corners and on the two center squares. Each of the
six symbols and six color/patterns are represented in the Opening Tableau.  
  

RULES OF PLAY  
  
At each turn, one stone from the pouch is displayed on the touchstone. 
Every stone has two attributes: a symbol and a background color/pattern. 
You'll try to place each stone on the board so that its color/pattern or
symbol matches the stone next to it.  You or other players then continue to
place stones until no more legal matches are possible or until the pouch is
empty.  
  
-Placing Stones:
  
Point the cursor to the spot you want to place the stone on the board and  
click the left mouse button once.  The stone on the touchstone will be placed
onto the square you selected.  
  
-Matching Stones :
  
Place each stone in a square next to (above, below, left or right - but NOT
DIAGONAL to) another stone, matching either the color/pattern or symbol
with the adjacent stone.  
  
To legally place a stone next to two other stones, your stone must match
one stone with the color/pattern attribute and match the second stone with
the symbol attribute.  
  
To legally place your stone so that it adjoins three other stones, you must
match two of the stones with one attribute, and the third stone with the
other attribute. 
  
After you gain a little experience making two- and three-way matches, try
your skill at a four-way match (4-Way).  To make a 4-Way, place a stone in
the center of four other stones, matching two of the stones on one
attribute and the other two stones on the other attribute.

-Developing a 4-Way (corner):

I. Initial stone (right-down corner)

	+----+----+----+
	|    |    |    |
	|    |    |    |
	|    |    |    |
	+----+----+----+
	|    |    |    |
	|    |    |    |
	|    |    |    |
	+----+----+----+
	|    |    |    |
	|    |    | A1 |
	|    |    |    |
	+----+----+----+

II. Place stones with the same color/symbol at each axis:

	+----+----+----+
	|    |    |    |
	|    |    | A6 |
	|    |    |    |
	+----+----+----+
	|    |    |    |  ^
	|    |    | A2 |  | Y-axis, stones with the same "color" (A)
	|    |    |    |
	+----+----+----+
	|    |    |    |
	| C1 | B1 | A1 |
	|    |    |    |
	+----+----+----+
		  <-- X-axis, stones with the same "symbol" (1)
	  
III. Close the confluence:

	+----+----+----+
	|    |    |    |
	|    | A6 | A3 |
	|    |    |    |
	+----+----+----+
	|    |    |    |
	| D1 |    | A2 |
	|    |    |    |
	+----+----+----+
	|    |    |    |
	| C1 | B1 | A1 |
	|    |    |    |
	+----+----+----+

IV. Make the 4-Way (A1 in the center matches D1 and B1 "symbol 1" and A2 and A6 "color A")

	+----+----+----+
	|    |    |    |
	|    | A6 | A3 |
	|    |    |    |
	+----+----+----+
	|    |    |    |
	| D1 | A1 | A2 |
	|    |    |    |
	+----+----+----+
	|    |    |    |
	| C1 | B1 | A1 |
	|    |    |    |
	+----+----+----+


-Developing a 4-Way (center of the board):

I. Initial stones

	+----+----+----+----+
	|    |    |    |    |
	|    |    |    |    |
	|    |    |    |    |
	+----+----+----+----+
	|    |    |    |    |
	|    | A1 |    |    |
	|    |    |    |    |
	+----+----+----+----+
	|    |    |    |    |
	|    |    | B2 |    |
	|    |    |    |    |
	+----+----+----+----+
	|    |    |    |    |
	|    |    |    |    |
	|    |    |    |    |
	+----+----+----+----+

II. Place stones with the same color/symbol at each axis:

	+----+----+----+----+
	|    |    |    |    |
	|    | D1 |    |    |
	|    |    |    |    |
	+----+----+----+----+
	|    |    |    |    |
	| A4 | A1 |    |    |
	|    |    |    |    |
	+----+----+----+----+
	|    |    |    |    |
	|    |    | B2 | B5 |
	|    |    |    |    |
	+----+----+----+----+
	|    |    |    |    |
	|    |    | C2 |    |
	|    |    |    |    |
	+----+----+----+----+

III. Close the confluences:

	+----+----+----+----+
	|    |    |    |    |
	|    | D1 | E1 |    |
	|    |    |    |    |
	+----+----+----+----+
	|    |    |    |    |
	| A4 | A1 |    | B6 |
	|    |    |    |    |
	+----+----+----+----+
	|    |    |    |    |
	| A5 |    | B2 | B5 |
	|    |    |    |    |
	+----+----+----+----+
	|    |    |    |    |
	|    | D2 | C2 |    |
	|    |    |    |    |
	+----+----+----+----+

IV. Make 2 4-Ways with A2 and B1:

      +----+----+----+----+
      |    |    |    |    |
      |    | D1 | E1 |    |
      |    |    |    |    |
      +----+----+----+----+
      |    |    |    |    |
      | A4 | A1 | B1 | B6 |
      |    |    |    |    |
      +----+----+----+----+
      |    |    |    |    |
      | A5 | A2 | B2 | B5 |
      |    |    |    |    |
      +----+----+----+----+
      |    |    |    |    |
      |    | D2 | C2 |    |
      |    |    |    |    |
      +----+----+----+----+


SCORING:
  
Players can get high scores by creating as many 4-Ways as possible, as
early in the game as possible, as they try to empty the pouch.
 
Players receive points by legally placing stones next to other stones in
the interior potion of the board (The Within).  The greater the number of
sides legally matched, the greater the number of points earned.
  
Points earned for legal matches are:  
  
      Single-sided match            1 point  
      Two-sided match               2 points  
      Three-sided match             4 points  
      Four-sided match (4-Way)      8 points  
  
Each 4-Way match earns bonus points and doubles the points awarded for  
subsequent matches.  For example, after the first 4-Way, a single-sided
match earns two points, a two-sided match earns four points, a three-sided
match earns eight points, and a 4-Way earns 16 points.  The next 4-Way
doubles the point scheme again, and so on.  
  
Bonuses awarded after each 4-Way match are:  
  
      First 4-Way                   25 points  
      Second 4-Way                  50 points  
      Third 4-Way                  100 points  
      Fourth 4-Way                 200 points  
      Fifth 4-Way                  400 points  
      Sixth 4-Way                  600 points  
      Seventh 4-Way                800 points  
      Eighth 4-Way               1,000 points  
      Ninth 4-Way                5,000 points  
      Tenth 4-Way               10,000 points  
      Eleventh 4-Way            25,000 points  
      Twelfth 4-Way             50,000 points  
 
At the end of the game, bonuses are awarded when fewer than three stones
remain in the pouch.  Bonuses awarded are:  
  
     Two stones left in pouch      100 points  
     One stone left in pouch       500 points  
     Empty pouch                  1000 points  
  
Since 4-Ways double the points achieved by matches and produce bonus
points, a player who scores four 4-Ways without placing all the stones can
actually score higher than a player who does empty the pouch but does not
make any 4-Ways.


STRATEGY 
 
To become a master player, you need to learn the art of emptying the pouch
while simultaneously creating as many 4-Way matches as possible. Using
all four corners as well as the center of the board increases your chance
of emptying the pouch and creating 4-Ways. 
 
Learn how to make 4-Ways and play ahead. You can build a strong game by
anticipating possible moves based on the stones you know are unplayed.





