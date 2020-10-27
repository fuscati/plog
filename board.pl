initial_board([
    [[white_ring,white_ball],[white_ring,white_ball],[empty,empty],[empty,empty],[empty,empty]],
    [[white_ring,white_ball],[empty,empty],[empty,empty],[empty,empty],[empty,empty]],
    [[empty,empty],[empty,empty],[empty,empty],[empty,empty],[empty,empty]],
    [[empty,empty],[empty,empty],[empty,empty],[empty,empty],[black_ring,black_ball]],
    [[empty,empty],[empty,empty],[empty,empty],[black_ring,black_ball],[black_ring,black_ball]]
]).

symbol(empty,S) :- S=' '.
symbol(black_ball,S) :- S='B'.
symbol(white_ball,S) :- S='W'.
symbol(white_ring,S) :- S='/'.
symbol(black_ring,S) :- S='*'.
symbol(black_white_ring,S) :- S='+'.
symbol(white_black_ring,S) :- S='+'.


symbol_ring(black_ball,S) :- S='   '.
symbol_ring(white_ball,S) :- S='   '.
symbol_ring(empty,S) :- S='   '.
symbol_ring(white_ring,S) :- S='///'.
symbol_ring(black_ring,S) :- S='***'.
symbol_ring(black_white_ring,S) :- S='+/+'.
symbol_ring(white_black_ring,S) :- S='+*+'.


letter(0, L) :- L='A'.
letter(1, L) :- L='B'.
letter(2, L) :- L='C'.
letter(3, L) :- L='D'.
letter(4, L) :- L='E'.



print_board(GameState):-
    nl,
    write('   | 0 | 1 | 2 | 3 | 4 |\n'),
    write('---|---|---|---|---|---|\n'),
    print_matrix(GameState, 0).


print_matrix([], 5).
print_matrix([Head|Tail], N) :-
    letter(N, L),
    N1 is N + 1,
    write('   |'),
    print_symbol_line(Head),
    nl,
    write(' '),
    write(L),
    write(' |'),
    print_line(Head),
    nl,
    write('   |'),
    print_symbol_line(Head),
    write('\n---|---|---|---|---|---|\n'),
    print_matrix(Tail, N1).


print_symbol_line([]).
print_symbol_line([Head|Tail]) :-
    print_symbol_ring(Head),
    write('|'),
    print_symbol_line(Tail).

print_line([]).
print_line([Head|Tail]) :-
    print_cell(Head),
    print_cell_end(Head),
    write('|'),
    print_line(Tail).

print_symbol_ring([Head|Tail]) :-
    symbol_ring(Head, S),
    write(S).


print_cell([]).
print_cell([Head|Tail]) :-
    symbol(Head, S),
    write(S),
    print_cell(Tail).

print_cell_end([Head|Tail]) :-
    symbol(Head, S),
    write(S).