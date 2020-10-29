check_add_ring(GameState,Row,Column,Rings):-
    get_ball(Columns, Row, Ball, GameState),
    check_add_ring_decision(GameState,Row,Column,Ball,Rings).

check_add_ring_decision(GameState,Row,Column,empty,Rings).

check_add_ring_decision(GameState,Row,Column,black_ball,Rings):-
    write('\nYou cant add a ring there. There is a ball'),
    read_add_ring(Rings,Player,Row,Column,NRow),
    check_add_ring(GameState,Row,Column,Rings).

check_add_ring_decision(GameState,Row,Column,white_ball):-
    write('\nYou cant add a ring there. There is a ball\n'),
    read_add_ring(Rings,Player,Row,Column,NRow,Rings),
    check_add_ring(GameState,Row,Column,Rings).
