play :-    
    initial(GameState),
    display_game(GameState,Player),
    game_white(GameState,Winner,8,8),
    nl,
    display_winner(Winner).

initial(GameState) :-
    
    initial_board(GameState).

display_game(GameState, Player) :-
    
    print_board(GameState).

display_winner(0):-
write('White won!!!!').

display_winner(1):-
write('Black won!!!').

option(1,GameState,Player,Rings):-
    nl,
    write(Rings),
    nl,
    read_add_ring(Rings,Player,Row,Column,NRow),
    check_add_ring(GameState,NRow,Column,Rings),
    add_ring(GameState,NRow,Column).




game_white(final_board_white,1).
game_white(final_board_black,2).

game_black(final_board_white,1).
game_black(final_board_black,2).

game_white(GameState,X,Rings_white,Rings_black):-
GameState\=final_board_white,
GameState\=final_board_black,
read_option(Option),
check_option(Option),
option(Option,GameState,'white',Rings_white),

/*syntax_validation(Piece, Column, Row),
logic_validation(Piece, Column, Row, GameState, Player),
move(Piece, Column, Row, GameState, Player),*/
display_game(GameState,Player).
/*
game_black(GameState,X,Rings_white,Rings_black).

game_black(GameState,X,Rings):-
GameState\=final_board_white,
GameState\=final_board_black,
read_play(Piece, Column, Row,Rings_black),
syntax_validation(Piece, Column, Row),
logic_validation(Piece, Column, Row, GameState, Player),
move(Piece, Column, Row, GameState, Player),
display_game(GameState,Player),
game_white(GameState,X,Rings_white,Rings_black).*/

