startGame(_Player1, _Player2) :-
    initial(GameState),
    %display_game(GameState,Player,8),
    play_loop(GameState,Winner,8,8),
    nl,
    display_winner(Winner).

play_loop(GameState,Winner,WhiteRings,BlackRings) :-
  /*GameState\=final_board_white,
  GameState\=final_board_black,*/
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
    write('\nPlease select where you want to add the ring\n'),
    getCoords(Row,Column),
    check_add_ring(GameState,Row,Column,Rings),
    add_ring(GameState,Player,Row,Column,Rings,NewRings,NewGameState).


read_move_ball(GameState,Player,NewGameState):-
    nl,
    read_ball_from_move(Player,Column_from,NRow_from),
    check_ball_from_move(Player,GameState,NRow_from,Column_from),
    read_ball_to_move(Player,Column_to,NRow_to),
    check_ball_to_move(Player,GameState,NRow_to,Column_to),
    write('WE DID IT BOIS'),
    can_move(GameState,Player,NRow_from,Column_from, Column_to, Row_to,Bool),
    nl,write('------------'),nl,write(Bool),nl,write('------------'),nl.
   /* %move_ball(GameState,NRow_from,Column_from,NRow_to,Column_to,NewGameState).

*/


game_white(GameState,X,Rings_white,Rings_black,NewGameState,NewRings):-
  /*GameState\=final_board_white,
  GameState\=final_board_black,*/
  nl,
  write('Player White'),
  nl,
  read_option(Option),
  check_option(Option,Rings_white,NewOption),
  option(NewOption,GameState,'white',Rings_white,NewRings,NewGameState),
  %display_game(NewGameState,'white',NewRings),
  read_move_ball(GameState,'white',NewGameState),
  display_game(NewGameState,'white',NewRings).



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
