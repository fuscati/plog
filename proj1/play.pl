play :-
    
    initial(GameState),
    display_game(GameState,Player).
    /*,
    game_white(GameState,Winner),
    nl,
    display_winner(Winner).*/

initial(GameState) :-
    
    initial_board(GameState).

display_game(GameState, Player) :-
    
    print_board(GameState).

display_winner(0):-
write('White won!!!!').

display_winner(1):-
write('Black won!!!').

game_white(final_board_white,1).
game_white(final_board_black,2).

game_black(final_board_white,1).
game_black(final_board_black,2).

game_white(GameState,X):-
GameState\=final_board_white,
GameState\=final_board_black,
read_play(Piece, Column, Row),
syntax_validation(Piece, Column, Row),
logic_validation(Piece, Column, Row, GameState, Player),
move(Piece, Column, Row, GameState, Player),
display_game(GameState,Player),
game_black(GameState,X).

game_black(GameState,X):-
GameState\=final_board_white,
GameState\=final_board_black,
read_play(Piece, Column, Row),
syntax_validation(Piece, Column, Row),
logic_validation(Piece, Column, Row, GameState, Player),
move(Piece, Column, Row, GameState, Player),
display_game(GameState,Player),
game_white(GameState,X).

