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
    write('Index = '),
    write(Index),
    replace_ring(GameState,Player,Row,Column,Ball,Rings,Index,NewGameState),
    NewRingsNumber is RingsNumber - 1.


can_move(GameState,Player,Row,Column, DestinationColumn, DestinationRow,Bool):-
    is_adjacent(Row,Column, DestinationRow, DestinationColumn, Bool),
    write('Adjacent: '),write(Bool),nl,
    get_ball(Column, Row, Ball, GameState),
    write('Ball: '),write(Ball),nl,
    ball_to_color(Ball,Color),
    (
        Color =:=Player ->
        Bool1 is Bool;
        Bool1 is 0

    ),
    Bool is Bool1,
    get_top_ring(DestinationColumn, DestinationRow, Ring, GameState),
    write('Ring: '),write(Ring),nl,
    ring_to_color(Ring,Color),
    (
        Color =:=Player ->
        Bool1 is Bool;
        Bool1 is 0
    ),
    Bool is Bool1.

is_adjacent(Row,Column, Row+1, Column+1, 1).
is_adjacent(Row,Column, Row, Column+1, 1).
is_adjacent(Row,Column, Row-1, Column+1, 1).
is_adjacent(Row,Column, Row+1, Column-1, 1).
is_adjacent(Row,Column, Row, Column-1, 1).
is_adjacent(Row,Column, Row-1, Column-1, 1).
is_adjacent(Row,Column, Row+1, Column, 1).
is_adjacent(Row,Column, Row-1, Column, 1).
is_adjacent(_,_, _, _, 0).

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

check_ball_to_move(Player,GameState,NRow_to,Column_to):-
    get_ball(Column_to, NRow_to, Ball, GameState),
    Empty is 'empty',
    (
       Ball=:=Empty->(    
    nl,
    read_ball_to_move(Player,Row,Column_to,NRow_to),
    check_ball_to_move(Player,GameState,NRow_to,Column_to)
    ); true
    ).