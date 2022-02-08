/***************************************/
%     CS 381 - Programming Lab #5       %
%                                       %
%  < Lin Tsu Ching >                    %
%  < lintsuc@oregonstate.edu >          %
%                                       %
/***************************************/

% load family tree
:- consult('royal.pl').

% enables piping in tests
portray(Term) :- atom(Term), format("~s", Term).



% your code here...
mother(M, C) :- parent(M, C), female(M).
father(M, C) :- parent(M, C), male(M).
spouse(M, FM) :- married(M, FM); married(FM, M).
child(C, M) :- mother(M, C); father(M, C).
son(C, M) :- parent(M, C), male(C).
daughter(C, M) :- parent(M, C), female(C).
sibling(X, Y) :- parent(M, X), parent(M, Y), X \= Y.
brother(M, X) :- sibling(M, X), male(M).
sister(M, X) :- sibling(M, X), female(M).

%uncle(M, C) :- male(M), sibling(X, M), parent(X, C).
%uncle(M, C) :- male(M), spouse(C, Y), sibling(X, Y), parent(X, C).
%aunt(M, C) :- female(M), parent(X, C), sister(M, X).
%aunt(M, C) :- female(M), parent(X, C), brother(Y, X), spouse(Y, M).
uncle(M, C) :- male(M), sibling(X, M), parent(X, C).
uncle(M, C) :- male(M), spouse(X, M), sibling(X, Y), parent(Y, C).
aunt(M, C) :- female(M), sibling(X, M), parent(X, C).
aunt(M, C) :- female(M), spouse(X, M), sibling(X, Y), parent(Y, C).
grandparent(M, C) :- parent(M, X), parent(X, C).
grandfather(M, C) :- grandparent(M, C), male(M).
grandmother(M, C) :- grandparent(M, C), female(M).
grandchild(C, M) :- grandparent(M, C).

ancestor(M, C) :- parent(M, C).
ancestor(M, C) :- parent(M, X), ancestor(X, C).
descendant(C, M) :- ancestor(M, C).

older(M, C) :- born(M, Yearm), born(C, Yearc), Yearm < Yearc.
younger(M, C) :- born(M, Yearm), born(C, Yearc), Yearm > Yearc.
regentWhenBorn(M, C) :- born(C, Year), reigned(M, Y1, Y2), (Y1 < Year, Year < Y2).

cousin(C, M) :- parent(X, M), sibling(X, Y), child(C, Y).