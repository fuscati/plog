play :-
    initial(GameState),
    display_game(GameState,Player,8),
    play_loop(GameState,Winner,8,8),
    nl,
    display_winner(Winner).

play_loop(GameState,Winner,WhiteRings,BlackRings) :-
  GameState\=final_board_white,
  GameState\=final_board_black,
  game_white(GameState,Winner,WhiteRings,BlackRings,NewWhiteGameState,NewWhiteRings),
  game_black(NewWhiteGameState,Winner,NewWhiteRings,BlackRings,NewBlackGameState,NewBlackRings),
  play_loop(NewBlackGameState,Winner,NewWhiteRings,NewBlackRings).

initial(GameState) :-
    initial_board(GameState).

display_game(GameState, Player, Rings) :-
    print_board(GameState,Player,Rings).

display_winner(0):-
write('White won!!!!').

display_winner(1):-
write('Black won!!!').

option(1,GameState,Player,Rings,NewRings,NewGameState):-
    nl,
    write(Rings),
    nl,
    read_add_ring(Rings,Player,Row,Column,NRow),
    check_add_ring(GameState,NRow,Column,Rings),
    add_ring(GameState,Player,NRow,Column,Rings,NewRings,NewGameState).


read_move_ball(GameState,Player,NewGameState):-
    nl,
    read_ball_from_move(Player,Row,Column_from,NRow_from),
    check_ball_from_move(GameState,NRow_from,Column_from),
    read_ball_to_move(Player,Row,Column_to,NRow_to),
    check_ball_to_move(GameState,NRow_to,Column_to),
    move_ball(GameState,NRow_from,Column_from,NRow_to,Column_to,NewGameState).


game_white(final_board_white,1).
game_white(final_board_black,2).

game_white(GameState,X,Rings_white,Rings_black,NewGameState,NewRings):-
  GameState\=final_board_white,
  GameState\=final_board_black,
  nl,
  write('Player White'),
  nl,
  read_option(Option),
  check_option(Option),
  option(Option,GameState,'white',Rings_white,NewRings,NewGameState),
  display_game(NewGameState,'white',NewRings),
  read_move_ball(GameState,Player,NewGameState),
  display_game(NewGameState,'white',NewRings).

game_black(final_board_white,1).
game_black(final_board_black,2).

game_black(GameState,X,Rings_white,Rings_black,NewGameState,NewRings):-
  GameState\=final_board_white,
  GameState\=final_board_black,
  nl,
  write('Player Black'),
  nl,
  read_option(Option),
  check_option(Option),
  option(Option,GameState,'black',Rings_black,NewRings,NewGameState),
  display_game(NewGameState,'black',NewRings),
  read_move_ball(GameState,Player,NewGameState),
  display_game(NewGameState,'black',NewRings).
