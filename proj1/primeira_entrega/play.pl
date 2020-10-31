
play :-
    initial(GameState),
    display_game(GameState,'white').

initial(GameState) :-
    initial_board(GameState).

display_game(GameState, Player) :- 
    print_board(GameState,Player).
