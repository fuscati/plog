%retorna em Ball a Bola na posição SelColumn SelRow de GameState
get_ball(SelColumn, SelRow, Ball, GameState) :-
  nth0(SelRow, GameState, BoardRow),
  nth0(SelColumn, BoardRow, BoardCell),
  nth0(0, BoardCell, Ball).

%retorna em BoardRow a linha na posição SelRow de GameState
get_row(SelRow, GameState, BoardRow) :-
  nth0(SelRow, GameState, BoardRow).

%retorna em Cell a casa na posição SelColumn SelRow de GameState
get_cell(SelColumn, SelRow,Cell, GameState):-
  nth0(SelRow, GameState, BoardRow),
  nth0(SelColumn, BoardRow, Cell).

%retorna em Rings a stacks de anéis da casa na posição SelColumn SelRow de GameState
get_rings(SelColumn, SelRow, Rings, Ball, GameState) :-
  nth0(SelRow, GameState, BoardRow),
  nth0(SelColumn, BoardRow, BoardCell),
  [Ball|Rings] = BoardCell.

%não há anel no topo
get_top_ring_index([],StartIndex,Index) :-
  Index is StartIndex.

%descobre um anel branco
get_top_ring_index(['white_ring'|_],StartIndex,Index) :-
  Index is StartIndex.

%descobre um anel preto
get_top_ring_index(['black_ring'|_],StartIndex,Index) :-
  Index is StartIndex.

%retorna em Index a posição do top_ring da stack de anéis  
get_top_ring_index([_|T],StartIndex,Index) :-
  NextIndex is StartIndex + 1,
  get_top_ring_index(T,NextIndex, Index).

%retorna em Ring o anel do topo da stack da casa na posição Row Column de GameState
get_top_ring(Row, Column, Ring, GameState) :-
  get_cell(Column,Row,[_|Rings], GameState),
  get_top_ring_cycle(Rings, Ring).

%não há anel no topo
get_top_ring_cycle([], 'empty').

%há um anel branco no topo
get_top_ring_cycle(['white_ring'|_], 'white_ring').

%há um anel preto no topo
get_top_ring_cycle(['black_ring'|_], 'black_ring').

%ciclo de procura do anel do topo
get_top_ring_cycle(['empty'|T], Ring) :-
  get_top_ring_cycle(T, Ring).

%substitui o anel da posição Index da casa na posição Row Column de GameState por um anel branco
replace_ring(GameState,'white',Row,Column,Ball,Rings,Index,NewGameState) :-
  I is Index - 1,
  replace(Rings,I,'white_ring',R),
  BR = [Ball|R],
  get_row(Row, GameState, NRow),
  replace(NRow, Column, BR, NewRow),
  replace(GameState, Row, NewRow, NewGameState).

%substitui o anel da posição Index da casa na posição Row Column de GameState por um anel preto
replace_ring(GameState,'black',Row,Column,Ball,Rings,Index,NewGameState) :-
  I is Index - 1,
  replace(Rings,I,'black_ring',R),
  BR = [Ball|R],
  get_row(Row, GameState, NRow),
  replace(NRow, Column, BR, NewRow),
  replace(GameState, Row, NewRow, NewGameState).

%substitui o anel da posição Index da casa na posição Row Column de GameState por um anel vazio
replace_ring(GameState,'empty',Row,Column,Ball,Rings,Index,NewGameState) :-
  replace(Rings,Index,'empty',R),
  BR = [Ball|R],
  get_row(Row, GameState, NRow),
  replace(NRow, Column, BR, NewRow),
  replace(GameState, Row, NewRow, NewGameState).

%substitui a bola na posição Row Column de GameState por Ball 
replace_ball(GameState,Row,Column,Ball,NewGameState):-
  get_cell(Column, Row,Cell, GameState),

  replace(Cell,0,Ball,NCell),

  get_row(Row, GameState, NRow),

  replace(NRow, Column, NCell, NewRow),

  replace(GameState, Row, NewRow, NewGameState).

%esvazia uma lista
empty_list([H|T],[]).

%substitui elementos de uma lista
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

%clona uma lista
clone([],[]).
clone([H|T],[H|Z]):- clone(T,Z).


%paralelo entre cor e bola 
ball_to_color('white_ball','white').
ball_to_color('black_ball','black').
ball_to_color('empty','empty').

%paralelo entre cor e anel
ring_to_color('white_ring','white').
ring_to_color('black_ring','black').

%descobre a direção em que é feito o vaulting num par DirectionR DirectionC em que cada um é no maximo 1 e no minimo 0
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
