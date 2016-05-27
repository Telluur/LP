:- initialization(main).
main :- init(Init), solve(Init, Solution),
        nl, write("Solution:"), nl, prettyprint(Solution), nl.

% moving the push or walk move to the front leads to non-termination
move(state(middle, box, middle, hasnot), grasp, state(middle, box, middle, has)).
move(state(P, floor, P, H), climb, state(P, box, P, H)).
move(state(P1, floor, P1, H), push(P1,P2), state(P2, floor, P2, H)).
move(state(P1, floor, B, H), walk(P1, P2), state(P2, floor, B, H)).

goal(state(_, _, _, has)).
init(state(door, floor, window, hasnot)).

solve(State) :- goal(State).
solve(State) :- move(State, _, State1), solve(State1).

solve(State, []) :- goal(State).
solve(State, [Move|Rest]) :- move(State, Move, State1), solve(State1, Rest).

solve_print(State) :- goal(State).
solve_print(State) :- move(State, _, State1), print(State -> State1), nl, solve_print(State1).

prettyprint([]).
prettyprint([X|List]) :- (is_list(X) -> prettyprint(X) ; write(X)), nl, prettyprint(List).
