father(X, Y) :- husband(X, Z), mother(Z, Y).

parent(P, C) :- mother(P, C).
parent(P, C) :- father(P, C).
child(C, P) :- parent(P, C).

son(C, P) :- child(C, P), male(P).
daughter(C, P) :- child(C, P), female(P).

grandmother(X, Y) :- mother(X, Z),parent(Z, Y).
grandfather(X, Y) :- father(X, Z),parent(Z, Y).
grandparent(X, Y) :- grandmother(X, Y) ; grandfather(X, Y).
grandchild(X, Y) :- grandparent(Y, X).

sister(X, Y) :- child(X, P), female(X), child(Y, P), not(X = Y).
brother(X, Y) :- child(X, P), male(X), child(Y, P), not(X = Y).

aunt(X, Y):- sister(X, Z), parent(Z, Y).
uncle(X, Y):- brother(X, Z), parent(Z, Y).
nephew(X, Y):- male(X), aunt(Y, X).
nephew(X, Y):- male(X), uncle(Y, X).
niece(X, Y):- female(X), aunt(Y, X).
niece(X, Y):- female(X), uncle(Y, X).
cousin(X, Y) :- parent(U, X), (sister(U, V) ; brother(U, V)) , parent(V, Y).

ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z),ancestor(Z, Y).
