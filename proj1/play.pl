play :-
    
    initial(GameState),
    display_game(GameState,Player).
    %game(GameState).

initial(GameState) :-
    
    initial_board(GameState).

display_game(GameState, Player) :-
    
    print_board(GameState).