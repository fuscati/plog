read_option(Option):-
    write('Please select your play\n'),
    write('Add new ring: 1\n'),
    write('Move ring: 2\n  || not implemented yet\n'),
    read(Option),
    write(Option).

check_option(1,0,Option):-
    write('\nYou have 0 Rings. You cannot add a ring\n'),
    read_option(Option),
    check_option(Option,0).

check_option(1,_,Option):-
Option=1.

check_option(2,_,Option):-
Option=2.


check_option(Option,Rings,Option):-
    Option>2,
    write('\nInvalid Option. Try again\n'),
    read_option(Option),
    check_option(Option).

read_add_ring(0,Player,Row,Column,NRow):-
    write('\nNot enough rings! Choose another option\n'),
    read_option(Option),
    check_option(Option),
    option(Option,GameState,Player,Rings).

read_add_ring(Rings,Player,Row,Column,NRow):-
    write('\nPlease select where you want to add the ring\n'),
    getCoords(NRow,Column).

read_move_ring(Player,Row,Column,NRow):-
    write('\nPlease select what ring you want to move\n'),
    getCoords(NRow,Column),
    nl,
    format('Row: ~w', [NRow, Column]).

read_ball_from_move(Player,Column,NRow):-
    write('\nPlease select from where you want to move a ball\n'),
    getCoords(NRow,Column).

read_ball_to_move(Player,Column,NRow):-
    write('\nPlease select to where you want to move the ball\n'),
    getCoords(NRow,Column).




/*read_column(Column):-
    write('Column- '),
    read(Column).

check_column(Column):-
    Column>=0,
    Column=<5.

check_column(Column):-
    (Column<0;Column>5),
    write('Invalid column! Try again.\n'),
    read_column(Column),
    check_option(Column).

read_row(Row):-
    write('Row- '),
    read(Row),
    nl.


check_row('A',0).
check_row('B',1).
check_row('C',2).
check_row('D',3).
check_row('E',4).

check_row('a',0).
check_row('b',1).
check_row('c',2).
check_row('d',3).
check_row('e',4).

check_row(Row,NRow):-
    write('Invalid row! Try again.\n'),
    write(Row),
    nl,
    read_row(Row),
    check_row(Row,NRow). */

letter_to_number('A',0).
letter_to_number('B',1).
letter_to_number('C',2).
letter_to_number('D',3).
letter_to_number('E',4).

getCoords(Row,Column):-
    manageColumn(Column),
    manageRow(Row).

manageRow(NewRow) :-
    readRow(Row),
    validateRow(Row, NewRow).

manageColumn(NewColumn) :-
    readColumn(Column),
    validateColumn(Column, NewColumn).

readRow(Row) :-
    write('  > Row    '),
    read(Row),
    nl,write(Row).

readColumn(Column) :-
    write('  > Column '),
    read(Column),
    nl,write(Column).

validateRow('A', 0).

validateRow('B', 1).

validateRow('C', 2).

validateRow('D', 3).

validateRow('E', 4).

validateRow(Row, NewRow) :-
    nl, write(NewRow),
    write('ERROR: That row is not valid!\n\n'),
    readRow(Input),
    validateRow(Input, NewRow).

validateColumn(0, NewColumn) :-
    NewColumn = 0.

validateColumn(1, NewColumn) :-
    NewColumn = 1.

validateColumn(2, NewColumn) :-
    NewColumn = 2.

validateColumn(3, NewColumn) :-
    NewColumn = 3.

validateColumn(4, NewColumn) :-
    NewColumn = 4.


validateColumn(_Column, NewColumn) :-
    write('ERROR: That column is not valid!\n\n'),
    readColumn(Input),
    validateColumn(Input, NewColumn).
