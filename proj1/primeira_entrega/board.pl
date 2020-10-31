

nitial_board([
    [[white_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,white_ring], [white_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,white_ring],  [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty]],
    [[white_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,white_ring], [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty]],
    [[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],           [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty]],
    [[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],           [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [black_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,black_ring]],
    [[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],           [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [black_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,black_ring],  [black_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,black_ring]]
]).

initial_board([
    [[white_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,white_ring], [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,white_ring],   [black_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,black_ring],  [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty]],
    [[white_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,white_ring], [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,white_ring],       [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty]],
    [[empty,empty,empty,empty,empty,empty,empty,empty,empty,black_ring,white_ring], [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [black_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,black_ring],  [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty]],
    [[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,white_ring],      [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,black_ring],       [white_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,white_ring],  [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty]],
    [[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],           [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [black_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,black_ring],  [black_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,black_ring]]
]).

nitial_board([
    [[black_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,black_ring], [black_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,black_ring],  [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty]],
    [[black_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,black_ring], [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty]],
    [[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],           [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty]],
    [[white_ball,empty,empty,empty,empty,empty,empty,empty,empty,white_ring,black_ring],           [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [white_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,white_ring]],
    [[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],           [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [white_ball,empty,empty,empty,empty,empty,empty,white_ring,black_ring,white_ring,black_ring]]
]).


symbol(empty,S) :- S=' '.
symbol(black_ball,S) :- S='B'.
symbol(white_ball,S) :- S='W'.
symbol(white_ring,S) :- S='w'.
symbol(black_ring,S) :- S='b'.
symbol(black_white_ring,S) :- S='+'.
symbol(white_black_ring,S) :- S='+'.


letter(0, L) :- L='A'.
letter(1, L) :- L='B'.
letter(2, L) :- L='C'.
letter(3, L) :- L='D'.
letter(4, L) :- L='E'.

print_rings('white'):-write('?'),nl.
print_rings('black'):-write('?'),nl.


print_board(GameState,Player):-
    nl,
    write('   | 0 | 1 | 2 | 3 | 4 |\n'),
    write('---|---|---|---|---|---|\n'),
    print_matrix(GameState, 0),
    nl,
    nl,
    write('Jogador: '),
    write(Player),
    nl,
    write('Aneis: '),
    print_rings(Player).


print_matrix([], 5).
print_matrix([Head|Tail], N) :-
    letter(N, L),
    N1 is N + 1,
    write('   |'),
    print_symbol_line1(Head),
    nl,
    write(' '),
    write(L),
    write(' |'),
    print_line(Head),
    nl,
    write('   |'),
    print_symbol_line2(Head),
    nl,
    write('   |'),
    print_symbol_line3(Head),
    write('\n---|---|---|---|---|---|\n'),
    print_matrix(Tail, N1).


print_symbol_line1([]).
print_symbol_line1([Head|Tail]) :-
    print_symbol_ring(Head,1),
    print_symbol_ring(Head,2),
    print_symbol_ring(Head,3),
    write('|'),
    print_symbol_line1(Tail).

print_symbol_line2([]).
print_symbol_line2([Head|Tail]) :-
    print_symbol_ring(Head,9),
    write(' '),
    print_symbol_ring(Head,5),
    write('|'),
    print_symbol_line2(Tail).

print_symbol_line3([]).
print_symbol_line3([Head|Tail]) :-
    print_symbol_ring(Head,8),
    print_symbol_ring(Head,7),
    print_symbol_ring(Head,6),
    write('|'),
    print_symbol_line3(Tail).

print_line([]).
print_line([Head|Tail]) :-
    print_symbol_ring(Head,10),
    print_ball(Head),
    print_symbol_ring(Head,4),
    write('|'),
    print_line(Tail).


print_symbol_ring([Head|Tail],0):-
    symbol(Head,S),
    write(S).

print_symbol_ring([Head|Tail],N):-
    N>0,
    N1 is N-1,
    print_symbol_ring(Tail,N1).


print_ball([Head|Tail]) :-
    symbol(Head,S),
    write(S).

