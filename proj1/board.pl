
%board inicial
initial_board([
    [[white_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,white_ring], [white_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,white_ring],  [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty]],
    [[white_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,white_ring], [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty]],
    [[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],           [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty]],
    [[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],           [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [black_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,black_ring]],
    [[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],           [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [black_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,black_ring],  [black_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,black_ring]]
]).

%board de teste para vaulting
vault_board([
    [[white_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,white_ring], [white_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,white_ring],  [black_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [white_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,white_ring]],
    [[white_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,white_ring], [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty]],
    [[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,white_ring],           [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty]],
    [[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,black_ring],           [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [black_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,black_ring]],
    [[empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],           [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],            [empty,empty,empty,empty,empty,empty,empty,empty,empty,empty,empty],        [black_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,black_ring],  [black_ball,empty,empty,empty,empty,empty,empty,empty,empty,empty,black_ring]]
]).

%template de board de vitória do jogador branco
final_board_white([
    [[_,_],[_,_],[_,_],[_,_],[_,_]],
    [[_,_],[_,_],[_,_],[_,_],[_,_]],
    [[_,_],[_,_],[_,_],[_,_],[_,_]],
    [[_,_],[_,_],[_,_],[_,_],[white_ball,_]],
    [[_,_],[_,_],[_,_],[white_ball,_],[white_ball,_]]
]).

%template de board de vitória do jogador preto
final_board_black([
    [[black_ball,_],[black_ball,_],[_,_],[_,_],[_,_]],
    [[black_ball,_],[_,_],[_,_],[_,_],[_,_]],
    [[_,_],[_,_],[_,_],[_,_],[_,_]],
    [[_,_],[_,_],[_,_],[_,_],[_,_]],
    [[_,_],[_,_],[_,_],[_,_],[_,_]]
]).


%transforma bolas e anéis em símbolos para a impressão
symbol(empty,S) :- S=' '.
symbol(black_ball,S) :- S='B'.
symbol(white_ball,S) :- S='W'.
symbol(white_ring,S) :- S='w'.
symbol(black_ring,S) :- S='b'.
symbol(black_white_ring,S) :- S='+'.
symbol(white_black_ring,S) :- S='+'.


%transforma números em letras
letter(0, L) :- L='A'.
letter(1, L) :- L='B'.
letter(2, L) :- L='C'.
letter(3, L) :- L='D'.
letter(4, L) :- L='E'.

print_rings('white'):-write('?'),nl.
print_rings('black'):-write('?'),nl.


%imprime o tabuleiro
print_board(GameState,Player):-
    nl,
    write('   | 0 | 1 | 2 | 3 | 4 |\n'),
    write('---|---|---|---|---|---|\n'),
    print_matrix(GameState, 0),
    nl.


%imprime a matriz do tabuleiro
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

%imprime a primeira linha de simbolos
print_symbol_line1([]).
print_symbol_line1([Head|Tail]) :-
    print_symbol_ring(Head,1),
    print_symbol_ring(Head,2),
    print_symbol_ring(Head,3),
    write('|'),
    print_symbol_line1(Tail).

%imprime a segunda linha de simbolos
print_symbol_line2([]).
print_symbol_line2([Head|Tail]) :-
    print_symbol_ring(Head,9),
    write(' '),
    print_symbol_ring(Head,5),
    write('|'),
    print_symbol_line2(Tail).

%imprime a terceira linha de simbolos
print_symbol_line3([]).
print_symbol_line3([Head|Tail]) :-
    print_symbol_ring(Head,8),
    print_symbol_ring(Head,7),
    print_symbol_ring(Head,6),
    write('|'),
    print_symbol_line3(Tail).

%imprime uma linha do tabuleiro
print_line([]).
print_line([Head|Tail]) :-
    print_symbol_ring(Head,10),
    print_ball(Head),
    print_symbol_ring(Head,4),
    write('|'),
    print_line(Tail).

%imprime o simbolo de um anel
print_symbol_ring([Head|Tail],0):-
    symbol(Head,S),
    write(S).

print_symbol_ring([Head|Tail],N):-
    N>0,
    N1 is N-1,
    print_symbol_ring(Tail,N1).

%imprime uma bola
print_ball([Head|Tail]) :-
    symbol(Head,S),
    write(S).

display_rings(Rings):-nl,write('Aneis: '),write(Rings),nl.