%le a opção
read_option(Option):-
    write('  > Please select your play\n'),
    write('  > Add new ring: 1\n'),
    write('  > Move ring: 2\n'),
    read(Option).

%verifica se há anéis suficientes
check_option(1,0,Option):-
    write('\nYou have 0 Rings. You cannot add a ring\n'),
    fail.

check_option(1,_,Option):-
Option=1.

check_option(2,_,Option):-
Option=2.

%opcao>2 não é válida
check_option(Option,Rings,Option):-
    Option>2,
    write('\nInvalid Option. Try again\n'),
    fail.

read_add_ring(0,Player,Row,Column,NRow):-
    write('\nNot enough rings! Choose another option\n'),
    read_option(Option),
    check_option(Option),
    option(Option,GameState,Player,Rings).

%le as coordenadas de adicionar um anel
read_add_ring(Rings,Player,Row,Column,NRow):-
    write('\nPlease select where you want to add the ring\n'),
    getCoords(NRow,Column).

%le as coordenadas de mover um anel
read_move_ring(Player,Row,Column,NRow):-
    write('\nPlease select which ring you want to move\n'),
    getCoords(NRow,Column).

%le a coordenadas da casa inicial do movimento da bola
read_ball_from_move(Player,Column,NRow):-
    write('\nPlease select from where you want to move a ball\n'),
    getCoords(NRow,Column).

%le as coordenadas da casa final do movimento da bola
read_ball_to_move(Player,Column,NRow):-
    write('\nPlease select to where you want to move the ball\n'),
    getCoords(NRow,Column).

%transforma uma letra num numero
letter_to_number('A',0).
letter_to_number('B',1).
letter_to_number('C',2).
letter_to_number('D',3).
letter_to_number('E',4).

%le as coordenadas 
getCoords(Row,Column):-
    manageColumn(Column),
    manageRow(Row).

%le e valida a linha
manageRow(NewRow) :-
    repeat,
    readRow(Row),
    (call(validateRow(Row, NewRow)) -> true, !; fail).

%le e valida a coluna
manageColumn(NewColumn) :-
    repeat,
    readColumn(Column),
    (call(validateColumn(Column, NewColumn)) -> true, !; fail).

%le a linha
readRow(Row) :-
    write('  > Row    '),
    read(Row).

%le a coluna
readColumn(Column) :-
    write('  > Column '),
    read(Column).

%Valida a linha
validateRow('A', 0).

validateRow('B', 1).

validateRow('C', 2).

validateRow('D', 3).

validateRow('E', 4).

validateRow(_Row, NewRow) :-
    write('ERROR: That row is not valid!\n\n'),
    fail.


%Valida a coluna
validateColumn(0, 0).

validateColumn(1, 1).

validateColumn(2, 2).

validateColumn(3, 3).

validateColumn(4, 4).

validateColumn(_Column, NewColumn) :-
    write('ERROR: That column is not valid!\n\n'),
    fail.
