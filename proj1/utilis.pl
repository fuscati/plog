get_ball(SelColumn, SelRow, Ball, GameState) :-
  nth0(SelRow, GameState, BoardRow),
  nth0(SelColumn, BoardRow, BoardCell),
  nth0(0, BoardCell, Ball).

get_row(SelRow, GameState, BoardRow) :-
  nth0(SelRow, GameState, BoardRow).

get_rings(SelColumn, SelRow, Rings, Ball, GameState) :-
  nth0(SelRow, GameState, BoardRow),
  nth0(SelColumn, BoardRow, BoardCell),
  [Ball|Rings] = BoardCell.

get_top_ring_index([],StartIndex,Index) :-
  Index is StartIndex,
  nl,
  write('No Ring found!').
get_top_ring_index(['white_ring'|_],StartIndex,Index) :-
  Index is StartIndex,
  nl,
  write('Ring found: white_ring').
get_top_ring_index(['black_ring'|_],StartIndex,Index) :-
  Index is StartIndex,
  nl,
  write('Ring found: black_ring').
get_top_ring_index([_|T],StartIndex,Index) :-
  NextIndex is StartIndex + 1,
  get_top_ring_index(T,NextIndex, Index).

get_top_ring(SelColumn, SelRow, Ring, GameState):-
  nth0(SelRow, GameState, BoardRow),
  nth0(SelColumn, BoardRow, BoardCell),
  top_ring_cycle(BoardCell, Ring,0),
  write(Ring).

top_ring_cycle(BoardCell, white_ring, N).

top_ring_cycle(BoardCell, black_ring, N).

top_ring_cycle(BoardCell, Ring, 11).

top_ring_cycle(BoardCell, Ring, N):-
  N<11,
  N1 is N+1,
  top_ring_cycle(BoardCell, Ring,N1).

replace_ring(GameState,'white',Row,Column,Ball,Rings,Index,NewGameState) :-
  I is Index - 1,
  replace(Rings,I,'white_ring',R),
  BR = [Ball|R],
  nl,
  write(BR),
  get_row(Row, GameState, NRow),
  replace(NRow, Column, BR, NewRow),
  replace(GameState, Row, NewRow, NewGameState).

replace_ring(GameState,'black',Row,Column,Ball,Rings,Index,NewGameState) :-
  I is Index - 1,
  replace(Rings,I,'black_ring',R),
  BR = [Ball|R],
  nl,
  write(BR),
  get_row(Row, GameState, NRow),
  replace(NRow, Column, BR, NewRow),
  replace(GameState, Row, NewRow, NewGameState).

replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

clone([],[]).
clone([H|T],[H|Z]):- clone(T,Z).


ball_to_color('white_ball','white').
ball_to_color('black_ball','black').

ring_to_color('white_ring','white').
ring_to_color('black_ring','black').
