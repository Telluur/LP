:- initialization(main).
main :- findall(X, go(X), Solutions), nl, prettyprint(Solutions).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Puzzle %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% go([stand(Day, IcecreamType, Name, Location)|...]) /1
% Solves the ice cream tour problem.
go(Model) :-    Model = [   stand(tuesday, _, _, _),
                            stand(wednesday, _, _, _),
                            stand(thursday, _, _, _),
                            stand(friday, _, _, _)],

% Sally’s Ice Cream wasn’t in Rockland.
                member(stand(A, _, _, rockland), Model),
                member(stand(B, _, sally, _), Model),
                not(A = B),

% Sherry didn’t get peppermint stick ice cream on Thursday night.
                member(stand(C, peppermint, _, _), Model),
                not(C = thursday),

% Sherry stopped at the ice cream stand in Granite on the day before she got the
% chocolate chip ice cream and the day after she stopped at Gary’s Ice Cream.
                sublist([   stand(_, _, gary, _),
                            stand(_, _, _, granite),
                            stand(_, chocolate_chip, _, _)], Model),

% At Tom’s Ice Cream she got peanut butter ice cream but not on Tuesday.
                member(stand(D, peanut_butter, tom, _), Model),
                not(D = tuesday),

% She got coffee bean ice cream on Wednesday, but not at Alice’s Ice Cream
                member(stand(wednesday, coffee_bean, _, _), Model),
                member(stand(E, _, alice, _), Model),
                not(E = wednesday),


% She stopped at the stand in Marsh the day before she stopped at
% Sally’s Ice Cream.
                sublist([   stand(_, _, _, marsh),
                            stand(_, _, sally, _)], Model),

% The ice she got in Boulder was gorgeous as well...
                member(stand(_, _, _, boulder), Model).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Utility %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% concat(Elem, List) /2
% Deterministic /3 internal predicate.
member(E, [H|T]) :- member_(T, E, H).
member_(_, E, E).
member_([H|T], E, _) :- member_(T, E, H).

% concat(List1, List2, List1AndList2) /3
concat([], L, L).
concat([H|T], L, [H|R]) :- concat(T, L, R).

% concat(ListOfLists, List) /3
concat([], []).
concat([L|Ls], Rl) :- concat(L, Ws, Rl), concat(Ls, Ws).

% sublist(Sublist, List) /2
% Continuous sublist
% sublist(S, L) :- concat(X, _, L), concat(_, S, X).
sublist(S, L) :- concat([_, S, _], L).

% prettyprint(List) /1
% prints each list item on a new line. If the list item is a list itself,
% then this list is printed after an empty line.
prettyprint([]).
prettyprint([X|List]) :- (is_list(X) -> prettyprint(X) ; write(X)), nl, prettyprint(List).
