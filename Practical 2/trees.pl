% Tree sturcture.
% nil.
% t(L, N, R).
%
% Most clauses have an extra clause with an appended capital letter G,
% these clauses print the tree graphically before and after the function to the screen.

% Assignment 1
% Check if argument passed is a binary tree
%
% istree(t(t(nil,2,nil),4,t(nil,5,t(nil,18,nil)))). -> True
% istree(t(t(2,2),4,nil)). -> False
istree(nil).
istree(t(L, _, R)) :- istree(L), istree(R).

% Assignment 2
% Find min and max values in a sorted binary tree
%
% min(t(t(t(nil, 1, nil), 2, nil), 3, nil), R). -> R = 1
% max(t(t(t(nil, 1, nil), 2, t(nil, 8, nil)), 18, t(t(nil, 21,nil), 81, t(nil, 218, nil))),R). -> R = 218
min(t(nil, N, _), N).
min(t(L, _, _), N) :- min(L, N).

max(t(_, N, nil), N).
max(t(_, _, R), N) :- max(R, N).

% Assignment 3
% Check if argument passed is a sorted binary tree
%
% issorted(t(t(nil,4,nil),5,t(nil,8,nil))). -> true
% issorted(t(t(nil,2,nil),1,nil)). -> false
% issorted(t(t(t(nil,0,nil),10,t(t(nil,20,nil),30,t(nil,40,nil))),50,t(t(nil,60,nil),80,t(t(nil,90,nil),100,t(nil,110,nil))))). -> true
% issorted(t(t(t(nil,0,nil),10,t(t(nil,20,nil),30,t(nil,40,nil))),50,t(t(nil,60,nil),80,t(t(nil,90,nil),1,t(nil,110,nil))))). -> false
issorted(t(nil,_,nil)).
issorted(t(L,N,nil)) :- max(L, X), X =< N, issorted(L).
issorted(t(nil, N, R)) :- min(R, Y), Y >= N, issorted(R).
issorted(t(L, N, R)) :- max(L, X), X =< N, min(R, Y), Y >= N, issorted(L), issorted(R).

% Assignment 4
% find a node conatining value N in an sorted tree.
%
% findG(t(t(nil,4,nil),5,t(nil,8,nil)), 3). -> false
% findG(t(t(nil,4,nil),5,t(nil,8,nil)), 5).
% findG(t(t(t(nil,0,nil),10,t(t(nil,20,nil),30,t(nil,40,nil))),50,t(t(nil,60,nil),80,t(t(nil,90,nil),100,t(nil,110,nil)))), 100).
find(t(L, N, R), N, t(L, N, R)).
find(t(L, V, R), N, S) :- (V > N -> find(L, N, S) ; find(R, N, S)).
findG(T, N) :- find(T, N, S), write("In tree: "), nl, printtree(T), write("Found a node containing the value "), write(N), nl, printtree(S).

% Assignment 5
% Insert a value N in a sorted binary tree.
%
% insertG(t(t(nil,4,nil),5,t(nil,8,nil)), 10).
% insertG(t(t(nil,4,nil),5,t(nil,8,nil)), 6).
% insertG(t(t(nil,4,nil),5,t(nil,8,nil)), 4).
% insertG(t(t(nil,4,nil),5,t(nil,8,nil)), 1).
insert(nil, N, t(nil, N, nil)).
insert(t(L, V, R), N, t(LR, VR, RR)) :- (N < V -> insert(L, N, U), (LR, VR, RR) = (U, V, R) ; insert(R, N, U), (LR, VR, RR) = (L, V, U)).
insertG(T, N) :- insert(T, N, S), write("Before insertion:"), nl, printtree(T), write("After insertion:"), nl, printtree(S).

% Assigment 6
% Delete a value N in a sorted binary tree.
%
% del deletes one instance of the number N
% delete deletes all instances of the number N
%
% delG(t(t(nil, 1, t(nil, 3, nil)), 5, t(t(nil, 6, nil), 8,nil)),1).
% delG(t(t(nil, 1, t(nil, 3, nil)), 5, t(t(nil, 6, nil), 8,nil)),4). -> false
% delG(t(t(t(nil, 0, nil), 7, nil), 10, t(nil, 10, t(t(nil, 10, nil), 15, t(nil, 20, nil)))), 10).
% deleteG(t(t(t(nil, 0, nil), 7, t(nil, 10 , nil)), 10, t(nil, 10, t(t(nil, 10, nil), 15, t(nil, 20, nil)))),10).
del(t(nil, N, nil), N, nil) :- !.
del(t(L, N, nil), N, L) :- !.
del(t(nil, N, R), N, R) :- !.
del(t(L, M, R), N, t(L, M, T)) :- M<N, delete(R, N, T), !.
del(t(L, M, R), N, t(T, M, R)) :- N<M, delete(L, N, T), !.
del(t(L, N, R), N, t(T, Z, R)) :- max(L,Z), delete(L, Z, T).
delG(T, N) :- del(T, N, TS), write("Before deletion:"), nl, printtree(T), write("After deletion: "), nl, printtree(TS).

delete(T, N, NT) :- find(T, N, _), !, del(T, N, TT), delete(TT, N, NT).
delete(T, _, T) :- !.
deleteG(T, N) :- delete(T, N, TS), write("Before deletion:"), nl, printtree(T), write("After deletion: "), nl, printtree(TS).

% Assignment 7
% Create a sorted binary tree from a list of integers.
%
% First we define an help clause, namely inserting a list of integers in an already sorted binary tree,
% we then simply define listtree as the insertlist clause where the already existing tree is defined as nil.
%
% listtreeG([4,2,1,3,6,5,7]).
listtree(L, S) :- insertlist(L, nil, S).
listtreeG(L) :- listtree(L, S), write("Created tree from list: "), write(L), nl, printtree(S).

insertlist([], S, S).
insertlist([Head|Tail], T, S) :- insert(T, Head, R), insertlist(Tail, R, S).
insertlistG(L, T) :- insertlist(L, T, S), write("Inserted list "), write(L), write(" into tree:"), nl, printtree(T), write("Giving tree:"), nl, printtree(S).

% Assignment 8
% Create a sorted list of numbers from a sorted binary tree.
%
% simple inorder traversal.
%
% treelistG(t(t(t(nil,0,nil),10,t(t(nil,20,nil),30,t(nil,40,nil))),50,t(t(nil,60,nil),80,t(t(nil,90,nil),100,t(nil,110,nil))))).
treelist(nil, []).
treelist(t(L, N, R), S) :- treelist(L, LS), append(LS, [N], U), treelist(R, RS), append(U, RS, S).
treelistG(T) :- treelist(T, S), write("Parsed tree:"), nl, printtree(T), write("Into list:"), nl, write(S).

% Assignment 9
% Sort an unsorted binary tree.
%
% the treesortG clause displays the tree before and after sorting.
%
% treesortG(t(t(t(nil,4,nil),2,t(nil,1,nil)),3,t(t(nil,6,nil),5,t(nil,7,nil)))).
treesort(T, S) :- treelist(T, TS), listtree(TS, S).
treesortG(T) :- treesort(T, S), write("Before sorting:"), nl, printtree(T), write("After sorting:"), nl, printtree(S).

% Assigment 11
% write a binary tree graphically to the screen.
%
% We perform an postorder traversal of the tree, while maintaining the depth of each node as we traverse it.
% Then we print postorder the depth of each node in tabs followed by its value.
% So a tree in the form of (excluding the nils): t(t(1),2,t(3))
% will print as follows:
%   3
% 2
%   1
%
% printtree(t(t(nil,4,nil),5,t(nil,8,nil))).
% printtree(t(t(t(nil,0,nil),10,t(t(nil,20,nil),30,t(nil,40,nil))),50,t(t(nil,60,nil),80,t(t(nil,90,nil),100,t(nil,110,nil))))).
printtree(T) :- istree(T),potprint(T, 0).
potprint(nil, _).
potprint(t(L, N, R), T) :- TN is T+1, potprint(R, TN), printvalue(N, T), potprint(L, TN). %prints N at depth T, and prints the node values of legs at depth TN recursively.
printvalue(N, T) :- T > 0, !, TN is T - 1, write('\t'), printvalue(N, TN). %keeps printing tabs, till correct depth has been reached.
printvalue(N, 0) :- write(N), write('\n').
