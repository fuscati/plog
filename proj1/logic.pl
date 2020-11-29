check_add_ring(GameState,Row,Column,Rings):-
    get_ball(Column, Row, Ball, GameState),
    check_add_ring_decision(GameState,Row,Column,Ball,Rings).

check_add_ring_decision(GameState,Row,Column,'empty',Rings).

check_add_ring_decision(GameState,Row,Column,'black_ball',Rings):-
    write('\nYou cant add a ring there. There is a ball'),
    read_add_ring(Rings,Player,Row,Column,NRow),
    check_add_ring(GameState,Row,Column,Rings).

check_add_ring_decision(GameState,Row,Column,'white_ball',Rings):-
    write('\nYou cant add a ring there. There is a ball\n'),
    read_add_ring(Rings,Player,Row,Column,NRow,Rings),
    check_add_ring(GameState,Row,Column,Rings).

add_ring(GameState,Player,Row,Column,RingsNumber,NewRingsNumber,NewGameState):-
    get_rings(Column, Row, Rings, Ball, GameState),
    get_top_ring_index(Rings,0,Index),
    nl,
    replace_ring(GameState,Player,Row,Column,Ball,Rings,Index,NewGameState),
    NewRingsNumber is RingsNumber - 1.

check_remove_ring(Player,GameState,Row,Column):-
  get_ball(Column, Row, Ball, GameState),
  get_top_ring(Row,Column,  TopRing, GameState),
  check_remove_ring_decision(Player,GameState,Row,Column,Ball,TopRing).

check_remove_ring_decision(Player,GameState,Row,Column,'black_ball',TopRing):-
  write('\nYou cant move a ring from here. There is a black ball'),
  read_move_ring(Player,Row,Column,NRow),
  check_remove_ring(Player,GameState,Row,Column,TopRing).

check_remove_ring_decision(Player,GameState,Row,Column,'white_ball',TopRing):-
    write('\nYou cant move a ring from here. There is a white ball'),
    read_move_ring(Player,Row,Column,NRow),
    check_remove_ring(Player,GameState,Row,Column,TopRing).

check_remove_ring_decision('white',GameState,Row,Column,'empty','black_ring'):-
  write('\nYou cant move a ring from here. Top ring is black'),
  read_move_ring(Player,Row,Column,NRow),
  check_remove_ring(Player,GameState,Row,Column,TopRing).

check_remove_ring_decision('black',GameState,Row,Column,'empty','white_ring'):-
  write('\nYou cant move a ring from here. Top ring is white'),
  read_move_ring(Player,Row,Column,NRow),
  check_remove_ring(Player,GameState,Row,Column,TopRing).

check_remove_ring_decision(_,_,_,_,'empty',_).

remove_ring(GameState,Player,Row,Column,RingsNumber,NewGameState):-
    get_rings(Column, Row, Rings, Ball, GameState),
    get_top_ring_index(Rings,0,Index),
    replace_ring(GameState,'empty',Row,Column,Ball,Rings,Index,NewGameState).

is_same(AuxR,AuxC,DestinationRow, DestinationColumn,Bool2):-
    AuxR=DestinationRow,
    AuxC=DestinationColumn,
    Bool is 1.

is_same(_,_,_, _,0).


can_vault(Row,Column, DestinationColumn, DestinationRow,Bool,GameState,Ball):-
    ball_to_color(Ball,Color),
    AuxC is Column,
    AuxR is Row,
    get_direction(Row,Column, DestinationColumn, DestinationRow,DirectionR,DirectionC),
    can_vault_cycle(AuxR,AuxC,DirectionR,DirectionC,1,1,Bool,GameState,DestinationRow,DestinationColumn).


can_vault_cycle(Row,Column,DirectionR,DirectionC,First_white,First_black,Bool,GameState,LastRow,LastColumn):-
    AuxR is Row + DirectionR,
    AuxC is Column + DirectionC,
    get_ball(AuxC,AuxR,Ball,GameState),
    ball_to_color(Ball,Color),
    nl,write('Vault_cycle values: Row, Column: '),write(Row),write(' ,'),write(Column),nl,
    write('Ball: '),write(Ball),nl,
    can_recolocate(Color,AuxR,AuxC,GameState,First_white,First_black,Bool1,LastRow,LastColumn,NFirst_white,NFirst_black),
    can_vault_cycle(AuxR,AuxC,DirectionR,DirectionC,NFirst_white,NFirst_black,Bool2,GameState,LastRow,LastColumn),
    Bool is Bool1*Bool2.

can_vault_cycle(AuxR,AuxC,_,_,_,_,Bool,_,LastRow,LastColumn):-
    AuxR=LastRow,
    AuxC=LastColumn,
    Bool is 1.


can_recolocate('empty',_,_,_GameState,_First_white,_First_black,1,_LastRow,_LastColumn,_NFirst_white,_NFirst_black).
can_recolocate('black',4,4,_GameState,_First_white,_First_black,0,_LastRow,_LastColumn,_NFirst_white,_NFirst_black).
can_recolocate('black',4,3,_GameState,_First_white,_First_black,0,_LastRow,_LastColumn,_NFirst_white,_NFirst_black).
can_recolocate('black',3,4,_GameState,_First_white,_First_black,0,_LastRow,_LastColumn,_NFirst_white,_NFirst_black).

can_recolocate('white',0,0,_GameState,_First_white,_First_black,0,_LastRow,_LastColumn,_NFirst_white,_NFirst_black).
can_recolocate('white',0,1,_GameState,_First_white,_First_black,0,_LastRow,_LastColumn,_NFirst_white,_NFirst_black).
can_recolocate('white',1,0,_GameState,_First_white,_First_black,0,_LastRow,_LastColumn,_NFirst_white,_NFirst_black).



can_recolocate('black',AuxR,AuxC,_GameState,_First_white,0,1,_LastRow,_LastColumn).
can_recolocate('white',AuxR,AuxC,_GameState,0,_First_black,1,_LastRow,_LastColumn).


can_recolocate(Color,_AuxR,_AuxC,GameState,First_white,First_black,Bool,LastRow,LastColumn,NFirst_white,NFirst_black):-
    findall([Column,Row], empty_ring_color(Column, Row, GameState,Color),L),
    nl,write('------------------'),nl,write(L),nl,write('------------------'),nl,
    length(L,Bool1),
    is_first_member(LastRow,LastColumn,L,BoolAux), 
    nl,write('Last Row / Last Column'), write(LastRow), write(' '),write(LastColumn),nl,

    Bool is Bool1-BoolAux,
    write('Bool: '),write(Bool),nl,
    color_to_first(Color,First_white,First_black,NFirst_white,NFirst_black).

is_first_member(_,_,[],0).
is_first_member(FirstRow,FirstColumn,[[A,B]|T],Bool):-
    ([A,B]=[FirstColumn,FirstRow] -> Bool is 1;Bool is 0).

color_to_first('white',First_white,_,NFirst_white,_NFirst_black):-
NFirst_white is 0.

color_to_first('black',_,First_black,_NFirst_white,NFirst_black):-
NFirst_black is 0.

color_to_first('empty',_,_First_black,_NFirst_white,_NFirst_black).


empty_ring_color(Column, Row, GameState,Color):-
    get_ball(Column, Row, 'empty', GameState),
    ring_to_color(Ring,Color),
    get_top_ring(Row, Column, Ring, GameState).

can_move(GameState,Player,Row,Column, DestinationColumn, DestinationRow,Bool):-
    Bool is 1,
    is_adjacent(Row, DestinationRow, Value),
    Bool1 is Bool*Value,
    Bool is Bool1,
    is_adjacent(Column, DestinationColumn, Value),
    Bool1 is Bool*Value,
    Bool is Bool1,
    get_ball(Column, Row, Ball, GameState),
    ball_to_color(Ball,Color),
    compare_color(Color,Player,Value),
    Bool1 is Bool*Value,
    Bool is Bool1,
    get_top_ring( DestinationRow,DestinationColumn, Ring, GameState),
    ring_to_color(Ring,Color),
    compare_color(Color,Player,Value),
    Bool1 is Bool*Value,
    Bool is Bool1.

can_move(GameState,Player,Row,Column, DestinationColumn, DestinationRow,Bool):-
    Bool1 is 1,
    get_ball(Column, Row, Ball, GameState),
    ball_to_color(Ball,Color),
    compare_color(Color,Player,Value),
    Bool2 is Bool1*Value,
    get_top_ring( DestinationRow,DestinationColumn, Ring, GameState),
    ring_to_color(Ring,Color),
    compare_color(Color,Player,Value),
    Bool3 is Bool2*Value,
    can_vault(Row,Column, DestinationColumn, DestinationRow,Bool_aux,GameState,Ball),
    Bool is Bool3*Bool_aux.

move_ball(GameState,Row_from,Column_from,Row_to,Column_to,NewGameState,Player):-
    replace_ball(GameState,Row_from,Column_from,'empty',NGameState),
    ball_to_color(Ball,Player),
    replace_ball(NGameState,Row_to,Column_to,Ball,NewGameState).


is_adjacent(0,0,1).
is_adjacent(1,0,1).
is_adjacent(0,1,1).
is_adjacent(1,1,1).
is_adjacent(2,1,1).
is_adjacent(1,2,1).
is_adjacent(2,2,1).
is_adjacent(3,2,1).
is_adjacent(2,3,1).
is_adjacent(3,3,1).
is_adjacent(4,3,1).
is_adjacent(3,4,1).
is_adjacent(4,4,1).


is_adjacent(_,_,0).



check_ball_from_move(Player,GameState,NRow_from,Column_from):-
    get_ball(Column_from, NRow_from, Ball, GameState),
    ball_to_color(Ball,Color),
    (
    Color\=Player->(
    nl,
    read_ball_from_move(Player,Row,Column_from,NRow_from),
    check_ball_from_move(Player,GameState,NRow_from,Column_from)
    ); true
    ).

check_ball_to_move(Player,GameState,Row_to,Column_to):-
    get_ball(Column_to, Row_to, Ball, GameState),
    is_empty(Ball,Empty),
    (
       Empty=:=0->(
    nl,
    write('There is a ball there. Try again'),
    write(Ball),
    read_ball_to_move(Player,Column_to,Row_to),
    check_ball_to_move(Player,GameState,Row_to,Column_to)
    ); true
    ).

is_empty('empty',1).
is_empty(_,0).

compare_color('white','white',1).
compare_color('black','black',1).
compare_color(_,_,0).
