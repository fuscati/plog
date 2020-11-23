check_add_ring(GameState,Row,Column,Rings):-
    get_ball(Column, Row, Ball, GameState),
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

add_ring(GameState,Player,Row,Column,RingsNumber,NewRingsNumber,NewGameState):-
    get_rings(Column, Row, Rings, Ball, GameState),
    get_top_ring(Rings,0,Index),
    nl,
    write('Index = '),
    write(Index),
    replace_ring(GameState,Player,Row,Column,Ball,Rings,Index,NewGameState),
    NewRingsNumber is RingsNumber - 1.
