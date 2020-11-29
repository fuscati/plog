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
    %vault_board(GameState).
    initial_board(GameState).

display_game(GameState, Player, Rings):- print_board(GameState,Player,Rings).

display_winner(1):-
write('White won!!!!').

display_winner(2):-
write('Black won!!!').

option(1,GameState,Player,Rings,NewRings,NewGameState):-
    get_add_ring_possibilities(GameState,Rings,Possibilities),
    (call(check_possibilities(Possibilities)) -> true, !; fail),
    repeat,
    read_add_ring(Rings,Player,Row,Column,NRow),
    (call(check_add_ring(GameState,NRow,Column,Rings,Bool)) -> true, !; fail),
    add_ring(GameState,Player,NRow,Column,Rings,NewRings,NewGameState).

get_add_ring_possibilities(GameState,Rings,Possibilities) :-
    findall([Column,Row], check_add_ring(GameState,Row,Column,Rings,true), Possibilities),
    nl,
    write('Add ring Possibilities: '),
    write(Possibilities).

option(2,GameState,Player,Rings,NewRings,NewGameState):-
    get_remove_ring_possibilities(GameState,Player,Possibilities),
    (call(check_possibilities(Possibilities)) -> true, !; fail),
    repeat,
    read_move_ring(Player,Row,Column,NRow),
    (call(check_remove_ring(Player,GameState,NRow,Column,Bool)) -> true, !; fail),
    remove_ring(GameState,Player,NRow,Column,Rings,NGameState),
    NewRings is Rings,
    option(1,NGameState,Player,8,_,NewGameState).

get_remove_ring_possibilities(GameState,Player,Possibilities) :-
    findall([Column,Row], check_remove_ring(Player,GameState,Row,Column,true), Possibilities),
    nl,
    write('Remove ring Possibilities: '),
    write(Possibilities).

check_possibilities([]) :-
  nl, write('There are no Possibilities'), fail.

check_possibilities([_|_]).

read_move_ball(GameState,Player,NGameState):-
    nl,
    read_ball_from_move(Player,Column_from,Row_from),
    check_ball_from_move(Player,GameState,Row_from,Column_from),
    read_ball_to_move(Player,Column_to,Row_to),
    check_ball_to_move(Player,GameState,Row_to,Column_to),
    can_move(GameState,Player,Row_from,Column_from, Column_to, Row_to,Bool,Vault),
    repeat_can_move(GameState,Player,Row_from,Column_from, Column_to, Row_to,Bool,Vault),
    move_ball(GameState,Row_from,Column_from,Row_to,Column_to,NewGameState,Player),
    display_game(NewGameState,Player,Rings),
    vault(NewGameState,Row_from,Column_from,Row_to,Column_to,NGameState,Player,Vault).

repeat_can_move(_GameState,_Player,_Row_from,_Column_from, _Column_to, _Row_to,Bool,_Vault):-
Bool>1.

repeat_can_move(GameState,Player,Row_from,_olumn_from, Column_to, Row_to,0,Vault):-
  nl,write('You cant move there'),nl,
  read_ball_from_move(Player,Column_from,Row_from),
  check_ball_from_move(Player,GameState,Row_from,Column_from),
  read_ball_to_move(Player,Column_to,Row_to),
  check_ball_to_move(Player,GameState,Row_to,Column_to),
  can_move(GameState,Player,Row_from,Column_from, Column_to, Row_to,Bool1,Vault),
  repeat_can_move(GameState,Player,Row_from,Column_from, Column_to, Row_to,Bool1).

get_option(Option,Rings) :-
  repeat,
  nl,
  read_option(Option),
  (call(check_option(Option,Rings,NewOption)) -> true, !; fail).

game_white(GameState,X,Rings_white,NewGameState,NewRings):-

  display_game(GameState,'white',Rings_white),
  nl,
  write('Player White'),
  repeat,
  get_option(Option,Rings_white),
  (call(option(Option,GameState,'white',Rings_white,NewRings,NGameState)) -> true, !; fail),
  display_game(NGameState,'white',NewRings),
  read_move_ball(NGameState,'white',NewGameState).

game_black(GameState,X,Rings_black,NewGameState,NewRings):-

  display_game(GameState,'black',Rings_black),
  nl,
  write('Player black'),
  repeat,
  get_option(Option,Rings_black),
  (call(option(NewOption,GameState,'black',Rings_black,NewRings,NGameState)) -> true, !; fail),
  display_game(NGameState,'black',NewRings),
  read_move_ball(NGameState,'black',NewGameState).
