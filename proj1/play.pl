startGame(_Player1, _Player2) :-
    initial(GameState),
    play_loop(GameState,-1,8,8),
    nl,
    display_winner(Winner).


play_loop(_,1,_,_).
play_loop(_,2,_,_).

winner_white(GameState,Winner):-
  GameState=final_board_white,
  Winner is 1.

winner_white(_,-1).

winner_black(GameState,Winner):-
  GameState=final_board_black,
  Winner is 2.

winner_black(_,-1).

play_loop(GameState,Winner,WhiteRings,BlackRings) :-

  game_white(GameState,Winner,WhiteRings,NewWhiteGameState,NewWhiteRings),
  winner_white(NewWhiteGameState,Winner),!,
  game_black(NewWhiteGameState,Winner,BlackRings,NewBlackGameState,NewBlackRings),
  winner_black(NewBlackGameState,Winner),!,
  play_loop(NewBlackGameState,Winner,NewWhiteRings,NewBlackRings).

initial(GameState) :-
    vault_board(GameState).
    %initial_board(GameState).

display_game(GameState, Player, Rings).
%:-
%print_board(GameState,Player,Rings).

display_winner(1):-
write('White won!!!!').

display_winner(2):-
write('Black won!!!').

option(1,GameState,Player,Rings,NewRings,NewGameState):-
    write('\nPlease select where you want to add the ring\n'),
    getCoords(Row,Column),
    check_add_ring(GameState,Row,Column,Rings),
    add_ring(GameState,Player,Row,Column,Rings,NewRings,NewGameState).

option(2,GameState,Player,Rings,NewRings,NewGameState):-
    write('\nPlease select which ring you want to move\n'),
    getCoords(Row,Column),
    check_remove_ring(Player,GameState,Row,Column),
    remove_ring(GameState,Player,Row,Column,Rings,NGameState),
    NewRings is Rings,
    option(1,NGameState,Player,8,_,NewGameState).

read_move_ball(GameState,Player,NewGameState):-
    nl,
    read_ball_from_move(Player,Column_from,Row_from),
    check_ball_from_move(Player,GameState,Row_from,Column_from),
    read_ball_to_move(Player,Column_to,Row_to),
    check_ball_to_move(Player,GameState,Row_to,Column_to),
    can_move(GameState,Player,Row_from,Column_from, Column_to, Row_to,Bool),
    move_ball(GameState,Row_from,Column_from,Row_to,Column_to,NewGameState,Player).


game_white(GameState,X,Rings_white,NewGameState,NewRings):-

  display_game(GameState,'white',Rings_white),
  nl,
  write('Player White'),
  nl,
  read_option(Option),
  check_option(Option,Rings_white,NewOption),
  option(NewOption,GameState,'white',Rings_white,NewRings,NGameState),
  display_game(NGameState,'white',NewRings),
  read_move_ball(NGameState,'white',NewGameState),
  display_game(NewGameState,'white',NewRings).

game_black(GameState,X,Rings_black,NewGameState,NewRings):-

  display_game(GameState,'black',Rings_black),
  nl,
  write('Player black'),
  nl,
  read_option(Option),
  check_option(Option,Rings_black,NewOption),
  option(NewOption,GameState,'black',Rings_black,NewRings,NewGameState),
  display_game(NewGameState,'black',NewRings),
  read_move_ball(NewGameState,'black',NGameState).
  display_game(NGameState,'black',NewRings).

