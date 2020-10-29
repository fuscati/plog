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