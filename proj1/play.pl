startGame('P', 'P') :-
    initial(GameState),
    play_loop(GameState,-1,8,8),
    nl,
    display_winner(Winner).

startGame('P', 'C') :-
    initial(GameState),
    play_loop2(GameState,-1,8,8),
    nl,
    display_winner(Winner).

%há vencedor e acaba o loop
play_loop(_,1,_,_).
play_loop(_,2,_,_).

play_loop2(_,1,_,_).
play_loop2(_,2,_,_).

%define o vencedor
winner_white(GameState,Winner):-
  GameState=final_board_white,
  Winner is 1.

winner_white(_,-1).

%define o vencedor
winner_black(GameState,Winner):-
  GameState=final_board_black,
  Winner is 2.

winner_black(_,-1).

%loop do jogo, faz uma jogada do preto e uma do branco alternadamente, verificando a condição de vitória
play_loop(GameState,Winner,WhiteRings,BlackRings) :-
  game_white(GameState,Winner,WhiteRings,NewWhiteGameState,NewWhiteRings),
  winner_white(NewWhiteGameState,Winner),!,
  game_black(NewWhiteGameState,Winner,BlackRings,NewBlackGameState,NewBlackRings),
  winner_black(NewBlackGameState,Winner),!,
  play_loop(NewBlackGameState,Winner,NewWhiteRings,NewBlackRings).

play_loop2(GameState,Winner,WhiteRings,BlackRings) :-
  %game_white(GameState,Winner,WhiteRings,NewWhiteGameState,NewWhiteRings),
  %winner_white(NewWhiteGameState,Winner),!,
  game_bot(GameState,Winner,BlackRings,NewBlackGameState,NewBlackRings),
  winner_black(NewBlackGameState,Winner),!,
  play_loop(NewBlackGameState,Winner,NewWhiteRings,NewBlackRings).

%constrói o estado de jogo inicial
initial(GameState) :-
    %vault_board(GameState).
    initial_board(GameState).

%imprime o jogo
display_game(GameState, Player, Rings):- print_board(GameState,Player,Rings).

display_winner(1):-
write('White won!!!!').

display_winner(2):-
write('Black won!!!').

%caso seja escolhida a opção 1 (adicionar um anel)
%le-se as coordenadas, verifica-se e adiciona-se
option(1,GameState,Player,Rings,NewRings,NewGameState):-
    get_add_ring_possibilities(GameState,Rings,Possibilities),
    (call(check_possibilities(Possibilities)) -> true, !; fail),
    repeat,
    read_add_ring(Rings,Player,Row,Column,NRow),
    (call(check_add_ring(GameState,NRow,Column,Rings,Bool)) -> true, !; fail),
    add_ring(GameState,Player,NRow,Column,Rings,NewRings,NewGameState).

%descobre todas as jogadas possíveis de adicionar anéis
get_add_ring_possibilities(GameState,Rings,Possibilities) :-
    findall([Column,Row], check_add_ring(GameState,Row,Column,Rings,true), Possibilities),
    nl,
    write('Add ring Possibilities: '),
    write(Possibilities).

%caso seja escolhida a opção 1 (mover um anel)
%le-se as coordenadas, verifica-se,remove-se da casa de partida e adiciona-se na casa de chegada
option(2,GameState,Player,Rings,NewRings,NewGameState):-
    get_remove_ring_possibilities(GameState,Player,Possibilities),
    (call(check_possibilities(Possibilities)) -> true, !; fail),
    repeat,
    read_move_ring(Player,Row,Column,NRow),
    (call(check_remove_ring(Player,GameState,NRow,Column,Bool)) -> true, !; fail),
    remove_ring(GameState,Player,NRow,Column,Rings,NGameState),
    NewRings is Rings,
    option(1,NGameState,Player,8,_,NewGameState).

option_bot(1,GameState,Player,Rings,NewRings,NewGameState):-
    get_add_ring_possibilities(GameState,Rings,Possibilities),
    (call(check_possibilities(Possibilities)) -> true, !; fail),
    get_easy_bot_decision_rings(Possibilities,Column,NRow),
    check_add_ring(GameState,NRow,Column,Rings,Bool),
    add_ring(GameState,Player,NRow,Column,Rings,NewRings,NewGameState).

get_easy_bot_decision_rings([[Column,Row]|_],Column,Row).

get_easy_bot_decision_ball([[[ColumnFrom,RowFrom],[ColumnTo,RowTo]]|_],ColumnFrom,RowFrom,ColumnTo,RowTo).

%descobre todas as jogadas possíveis de remover anéis para depois os mover
get_remove_ring_possibilities(GameState,Player,Possibilities) :-
    findall([Column,Row], check_remove_ring(Player,GameState,Row,Column,true), Possibilities),
    nl,
    write('Remove ring Possibilities: '),
    write(Possibilities).

check_possibilities([]) :-
  nl, write('There are no Possibilities'), fail.

check_possibilities([_|_]).

get_move_ball_possibilities(GameState,Player,Possibilities):-
  setof([[Row_from,Column_from],[Column_to,Row_to]],can_move(GameState,Player,Row_from,Column_from, Row_to, Column_to,1,Vault), Possibilities),
  nl,
  write('Move Ball Possibilities: '),
  write(Possibilities).

%trata de todo o procedimento de mexer uma bola, ler as coordenadas das casas inicial e final
%verifica se pode mover, se se poder mover move, dá display e realiza o vaulting se Vault for 1
read_move_ball(GameState,Player,NGameState):-
    get_move_ball_possibilities(GameState,Player,Possibilities),
    nl,
    read_ball_from_move(Player,Column_from,Row_from),
    check_ball_from_move(Player,GameState,Row_from,Column_from),
    read_ball_to_move(Player,Column_to,Row_to),
    check_ball_to_move(Player,GameState,Row_to,Column_to),
    can_move(GameState,Player,Row_from,Column_from, Row_to, Column_to,Bool,Vault),
    repeat_can_move(GameState,Player,Row_from,Column_from, Column_to, Row_to,Bool,Vault),
    move_ball(GameState,Row_from,Column_from,Row_to,Column_to,NewGameState,Player),
    display_game(NewGameState,Player,Rings),
    vault(NewGameState,Row_from,Column_from,Row_to,Column_to,NGameState,Player,Vault).

read_move_ball_bot(GameState,Player,ColumnFrom,RowFrom,ColumnTo,RowTo,NGameState):-
    check_ball_from_move(Player,GameState,RowFrom,ColumnFrom),
    check_ball_to_move(Player,GameState,RowTo,ColumnTo),
    can_move(GameState,Player,RowFrom,ColumnFrom,RowTo,ColumnTo,Bool,Vault),
    repeat_can_move(GameState,Player,RowFrom,ColumnFrom,ColumnTo,RowTo,Bool,Vault),
    move_ball(GameState,RowFrom,ColumnFrom,RowTo,ColumnTo,NewGameState,Player),
    display_game(NewGameState,Player,Rings),
    vault(NewGameState,RowFrom,ColumnFrom,RowTo,ColumnTo,NGameState,Player,Vault).

repeat_can_move(_GameState,_Player,_Row_from,_Column_from, _Column_to, _Row_to,Bool,_Vault):-
Bool>0.

%Bool=0, logo foi detetada uma inconformidade no input dos dados, repete-se o processo
repeat_can_move(GameState,Player,Row_from,_olumn_from, Column_to, Row_to,0,Vault):-
  nl,write('You cant move there'),nl,
  read_ball_from_move(Player,Column_from,Row_from),
  check_ball_from_move(Player,GameState,Row_from,Column_from),
  read_ball_to_move(Player,Column_to,Row_to),
  check_ball_to_move(Player,GameState,Row_to,Column_to),
  can_move(GameState,Player,Row_from,Column_from, Row_to, Column_to,Bool1,Vault),
  repeat_can_move(GameState,Player,Row_from,Column_from, Column_to, Row_to,Bool1).

get_option(Option,Rings) :-
  repeat,
  nl,
  read_option(Option),
  (call(check_option(Option,Rings,NewOption)) -> true, !; fail).

%jogadas das brancas, le a opção, trata a opcao e, dá display e trata o movimento da bola
game_white(GameState,X,Rings_white,NewGameState,NewRings):-

  display_game(GameState,'white',Rings_white),
  nl,
  write('Player White'),
  repeat,
  get_option(Option,Rings_white),
  (call(option(Option,GameState,'white',Rings_white,NewRings,NGameState)) -> true, !; fail),
  display_game(NGameState,'white',NewRings),
  read_move_ball(NGameState,'white',NewGameState).

%jogadas das pretas, le a opção, trata a opcao e, dá display e trata o movimento da bola
game_black(GameState,X,Rings_black,NewGameState,NewRings):-

  display_game(GameState,'black',Rings_black),
  nl,
  write('Player black'),
  repeat,
  get_option(Option,Rings_black),
  (call(option(NewOption,GameState,'black',Rings_black,NewRings,NGameState)) -> true, !; fail),
  display_game(NGameState,'black',NewRings),
  read_move_ball(NGameState,'black',NewGameState).

game_bot(GameState,X,Rings_black,NewGameState,NewRings) :-
  display_game(GameState,'black',Rings_black),
  nl,
  write('Player black'),
  option_bot(1,GameState,'black',Rings_black,NewRings,NGameState),
  display_game(NGameState,'black',NewRings).
  %read_move_ball(NGameState,'black',NewGameState).
  %get_move_ball_possibilities(NGameState,'black',Possibilities),
  %nl,
  %write(Possibilities),
  %get_easy_bot_decision_ball(Possibilities,ColumnFrom,RowFrom,ColumnTo,RowTo),
  %format('\nCFrom: ~w RFrom: ~w CTo: ~w RTo: ~w', [ColumnFrom,RowFrom,ColumnTo,RowTo]).
  %read_move_ball_bot(NGameState,'black',ColumnFrom,RowFrom,ColumnTo,RowTo,NewGameState).
