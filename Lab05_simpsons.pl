% ============================================================
%  ARTI 303 - Lab 5  |  Working with Rules
%  Task 1 - Knowledge base for the Simpsons family tree
% ============================================================

% ---------------- Facts: male ----------------
male(abraham).
male(clancy).
male(herb).
male(homer).
male(bart).

% ---------------- Facts: female ----------------
female(mona).
female(jackie).
female(marge).
female(patty).
female(selma).
female(lisa).
female(maggie).
female(ling).

% ---------------- Facts: parent(Parent, Child) ----------------
parent(abraham, herb).
parent(abraham, homer).
parent(mona, homer).

parent(clancy, marge).
parent(clancy, patty).
parent(clancy, selma).
parent(jackie, marge).
parent(jackie, patty).
parent(jackie, selma).

parent(homer, bart).
parent(homer, lisa).
parent(homer, maggie).
parent(marge, bart).
parent(marge, lisa).
parent(marge, maggie).

parent(selma, ling).

% ============================================================
%  Rules
% ============================================================

% X is the father of Y if X is a parent of Y and X is male.
father(X, Y) :- parent(X, Y), male(X).

% X is the mother of Y if X is a parent of Y and X is female.
mother(X, Y) :- parent(X, Y), female(X).

% X is the son of Y if Y is a parent of X and X is male.
son(X, Y) :- parent(Y, X), male(X).

% X is the daughter of Y if Y is a parent of X and X is female.
daughter(X, Y) :- parent(Y, X), female(X).

% Helper: X and Y are siblings if they share a parent and are different people.
sibling(X, Y) :- parent(P, X), parent(P, Y), X \= Y.

% X is the brother of Y if they are siblings and X is male.
brother(X, Y) :- sibling(X, Y), male(X).

% X is the sister of Y if they are siblings and X is female.
sister(X, Y) :- sibling(X, Y), female(X).

% X is the grandfather of Z if X is a parent of a parent of Z and X is male.
grandfather(X, Z) :- parent(X, Y), parent(Y, Z), male(X).

% X is the uncle of N if X is a brother of one of N's parents.
uncle(X, N) :- parent(P, N), brother(X, P).

% X is the aunt of N if X is a sister of one of N's parents.
aunt(X, N) :- parent(P, N), sister(X, P).

% X and Y are cousins if their parents are siblings.
cousin(X, Y) :- parent(P1, X), parent(P2, Y), sibling(P1, P2).

% Recursive rule: X is an ancestor of Y.
ancestor(X, Y) :- parent(X, Y).                    % base case
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).    % recursive case

% ============================================================
%  Queries and answers (two or more per rule)
%  Note: some answers repeat (e.g. lisa twice) because the
%  two people share BOTH parents, so Prolog finds them twice.
% ============================================================

/*
---------- father ----------
?- father(homer, bart).
true.

?- father(X, lisa).
X = homer ;
false.

---------- mother ----------
?- mother(marge, maggie).
true.

?- mother(X, homer).
X = mona.

---------- son ----------
?- son(X, abraham).
X = herb ;
X = homer.

?- son(bart, X).
X = homer ;
X = marge.

---------- daughter ----------
?- daughter(X, clancy).
X = marge ;
X = patty ;
X = selma.

?- daughter(ling, X).
X = selma.

---------- brother ----------
?- brother(X, homer).
X = herb ;
false.

?- brother(bart, X).
X = lisa ;
X = maggie ;
X = lisa ;
X = maggie.

---------- sister ----------
?- sister(X, marge).
X = patty ;
X = selma ;
X = patty ;
X = selma ;
false.

?- sister(lisa, maggie).
true .

---------- grandfather ----------
?- grandfather(X, bart).
X = abraham ;
X = clancy ;
false.

?- grandfather(clancy, X).
X = bart ;
X = lisa ;
X = maggie ;
X = ling.

---------- uncle ----------
?- uncle(X, bart).
X = herb ;
false.

?- uncle(herb, X).
X = bart ;
X = lisa ;
X = maggie ;
false.

---------- aunt ----------
?- aunt(patty, bart).
true .

?- aunt(X, ling).
X = marge ;
X = patty ;
X = marge ;
X = patty ;
false.

---------- cousin ----------
?- cousin(bart, ling).
true .

?- cousin(ling, X).
X = bart ;
X = bart ;
X = lisa ;
X = lisa ;
X = maggie ;
X = maggie ;
false.

---------- ancestor ----------
?- ancestor(X, bart).
X = homer ;
X = marge ;
X = abraham ;
X = mona ;
X = clancy ;
X = jackie ;
false.

?- ancestor(clancy, X).
X = marge ;
X = patty ;
X = selma ;
X = bart ;
X = lisa ;
X = maggie ;
X = ling ;
false.
*/
