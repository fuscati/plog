get_ball(SelColumn, SelRow, Ball, GameState) :-
  nth0(SelRow, GameState, BoardRow),
  nth0(SelColumn, BoardRow, BoardCell),
  nth0(0, BoardCell, Ball).

get_row(SelRow, GameState, BoardRow) :-
  nth0(SelRow, GameState, BoardRow).

get_cell(SelColumn, SelRow,Cell, GameState):-
  nth0(SelRow, GameState, BoardRow),
  nth0(SelColumn, BoardRow, Cell).

get_rings(SelColumn, SelRow, Rings, Ball, GameState) :-
  nth0(SelRow, GameState, BoardRow),
  nth0(SelColumn, BoardRow, BoardCell),
  [Ball|Rings] = BoardCell.

get_top_ring_index([],StartIndex,Index) :-
  Index is StartIndex,
  nl.

get_top_ring_index(['white_ring'|_],StartIndex,Index) :-
  Index is StartIndex,
  nl.

get_top_ring_index(['black_ring'|_],StartIndex,Index) :-
  Index is StartIndex,
  nl.

get_top_ring_index([_|T],StartIndex,Index) :-
  NextIndex is StartIndex + 1,
  get_top_ring_index(T,NextIndex, Index).

get_top_ring(Row, Column, Ring, GameState) :-
  get_cell(Column,Row,[_|Rings], GameState),
  get_top_ring_cycle(Rings, Ring).

get_top_ring_cycle([], 'empty').

get_top_ring_cycle(['white_ring'|_], 'white_ring').

get_top_ring_cycle(['black_ring'|_], 'black_ring').

get_top_ring_cycle(['empty'|T], Ring) :-
  get_top_ring_cycle(T, Ring).

replace_ring(GameState,'white',Row,Column,Ball,Rings,Index,NewGameState) :-
  I is Index - 1,
  replace(Rings,I,'white_ring',R),
  BR = [Ball|R],
  write(BR),
  get_row(Row, GameState, NRow),
  replace(NRow, Column, BR, NewRow),
  replace(GameState, Row, NewRow, NewGameState).

replace_ring(GameState,'black',Row,Column,Ball,Rings,Index,NewGameState) :-
  I is Index - 1,
  replace(Rings,I,'black_ring',R),
  BR = [Ball|R],
  get_row(Row, GameState, NRow),
  replace(NRow, Column, BR, NewRow),
  replace(GameState, Row, NewRow, NewGameState).

replace_ring(GameState,'empty',Row,Column,Ball,Rings,Index,NewGameState) :-
  replace(Rings,Index,'empty',R),
  BR = [Ball|R],
  get_row(Row, GameState, NRow),
  replace(NRow, Column, BR, NewRow),
  replace(GameState, Row, NewRow, NewGameState),
  write(R).

replace_ball(GameState,Row,Column,Ball,NewGameState):-
  get_cell(Column, Row,Cell, GameState),

  replace(Cell,0,Ball,NCell),

  get_row(Row, GameState, NRow),

  replace(NRow, Column, NCell, NewRow),

  replace(GameState, Row, NewRow, NewGameState).

empty_list([H|T],[]).

replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

clone([],[]).
clone([H|T],[H|Z]):- clone(T,Z).


ball_to_color('white_ball','white').
ball_to_color('black_ball','black').
ball_to_color('empty','empty').

ring_to_color('white_ring','white').
ring_to_color('black_ring','black').

get_direction(Row,Column, DestinationColumn, DestinationRow,DirectionR,DirectionC):-
    Row=DestinationRow,
    DirectionR is 0,
    Column > DestinationColumn,
    DirectionC is -1.

get_direction(Row,Column, DestinationColumn, DestinationRow,DirectionR,DirectionC):-
    Row=DestinationRow,
    DirectionR is 0,
    Column < DestinationColumn,
    DirectionC is 1.

get_direction(Row,Column, DestinationColumn, DestinationRow,DirectionR,DirectionC):-
    Row>DestinationRow,
    DirectionR is -1,
    Column = DestinationColumn,
    DirectionC is 0.

get_direction(Row,Column, DestinationColumn, DestinationRow,DirectionR,DirectionC):-
    Row<DestinationRow,
    DirectionR is 1,
    Column = DestinationColumn,
    DirectionC is 0.

get_direction(Row,Column, DestinationColumn, DestinationRow,DirectionR,DirectionC):-
    Row<DestinationRow,
    Column<DestinationColumn,
    DestinationRow-Row=DestinationColumn-Column,
    DirectionR is 1,
    DirectionC is 1.

get_direction(Row,Column, DestinationColumn, DestinationRow,DirectionR,DirectionC):-
    Row>DestinationRow,
    Column>DestinationColumn,
    DestinationRow-Row=DestinationColumn-Column,
    DirectionR is -1,
    DirectionC is -1.

get_direction(Row,Column, DestinationColumn, DestinationRow,DirectionR,DirectionC):-
    Row>DestinationRow,
    Column<DestinationColumn,
    Row-DestinationRow=DestinationColumn-Column,
    DirectionR is -1,
    DirectionC is 1.

get_direction(Row,Column, DestinationColumn, DestinationRow,DirectionR,DirectionC):-
    Row<DestinationRow,
    Column>DestinationColumn,
    DestinationRow-Row=Column-DestinationColumn,
    DirectionR is 1,
    DirectionC is -1.
