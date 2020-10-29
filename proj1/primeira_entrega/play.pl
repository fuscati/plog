play :-    
    initial(GameState),
    display_game(GameState,Player).

initial(GameState) :-
    initial_board(GameState).

display_game(GameState, Player) :- 
    print_board(GameState).
