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
    get_top_ring(DestinationColumn, DestinationRow, Ring, GameState),
    ring_to_color(Ring,Color),
    compare_color(Color,Player,Value),
    Bool1 is Bool*Value,
    Bool is Bool1.

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
is_adjacent(5,4,1).

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