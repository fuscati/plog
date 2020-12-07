initBalls([[0,0],[1,0],[0,1]]).

test_position_adjacent_to_ball:-
  initBalls(Ball_Positions),
  setof([Column, Row], is_position_adjacent_to_ball(Column, Row, Ball_Positions, true), AdjacentPositions),
  write(AdjacentPositions).

is_position_adjacent_to_ball(Column, Row, Ball_Positions, Bool):-
  is_adjacent_to_ball_cycle(Column, Row, Ball_Positions, Bool).

is_adjacent_to_ball_cycle(Column ,Row, [], false).
is_adjacent_to_ball_cycle(Column, Row, [[BallColumn,BallRow]|T], Bool):-
  is_adjacent_to_ball_cycle(Column ,Row, T, Bool2),
  are_positions_adjacent(Column, Row, BallColumn, BallRow, Bool1),
  check_bools_or(Bool1, Bool2, Bool).

are_positions_adjacent(Column, Row, Column2, Row2, Bool):-
  are_columns_adjancent(Column, Column2, Bool1),
  are_rows_adjancent(Row, Row2, Bool2),
  check_bools_and(Bool1, Bool2, Bool).

check_bools_and(true, true, true).
check_bools_and(_, _, false).

check_bools_or(true, false, true).
check_bools_or(false, true, true).
check_bools_or(true, true, true).
check_bools_or(_, _, false).

are_columns_adjancent(0, 1, true).
are_columns_adjancent(1, 2, true).
are_columns_adjancent(2, 3, true).
are_columns_adjancent(3, 4, true).
are_columns_adjancent(4, 3, true).
are_columns_adjancent(3, 2, true).
are_columns_adjancent(2, 1, true).
are_columns_adjancent(1, 0, true).
are_columns_adjancent(X, X, true).
are_columns_adjancent(_, _, false).

are_rows_adjancent(0, 1, true).
are_rows_adjancent(1, 2, true).
are_rows_adjancent(2, 3, true).
are_rows_adjancent(3, 4, true).
are_rows_adjancent(4, 3, true).
are_rows_adjancent(3, 2, true).
are_rows_adjancent(2, 1, true).
are_rows_adjancent(1, 0, true).
are_rows_adjancent(X, X, true).
are_rows_adjancent(_, _, false).
