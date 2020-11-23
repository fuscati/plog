get_ball(SelColumn, SelRow, Ball, GameState) :-
  nth0(SelRow, GameState, BoardRow),
  /*write('BoardRow:'),
  write(BoardRow),
  nl,*/
  nth0(SelColumn, BoardRow, BoardCell),
  /*write('Content:'),
  write(BoardCell),
  nl,*/
  nth0(0, BoardCell, Ball)
  /*,
  format('\nBall: ~d ~d\nContent: ', [SelColumn, SelRow]),
  write(Ball),
  nl*/
  .

get_row(SelRow, GameState, BoardRow) :-
  nth0(SelRow, GameState, BoardRow).

get_rings(SelColumn, SelRow, Rings, Ball, GameState) :-
  nth0(SelRow, GameState, BoardRow),
  nth0(SelColumn, BoardRow, BoardCell),
  [Ball|Rings] = BoardCell.

get_top_ring([],StartIndex,Index) :-
  Index is StartIndex,
  nl,
  write('No Ring found!').
get_top_ring(['white_ring'|_],StartIndex,Index) :-
  Index is StartIndex,
  nl,
  write('Ring found: white_ring').
get_top_ring(['black_ring'|_],StartIndex,Index) :-
  Index is StartIndex,
  nl,
  write('Ring found: black_ring').
get_top_ring([_|T],StartIndex,Index) :-
  NextIndex is StartIndex + 1,
  get_top_ring(T,NextIndex, Index).

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
