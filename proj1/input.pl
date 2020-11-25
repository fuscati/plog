read_option(Option):-
    write('Please select your play\n'),
    write('Add new ring: 1\n'),
    write('Move ring: 2\n  || not implemented yet\n'),
    read(Option),
    write(Option).
    
check_option(1).
check_option(2).


check_option(Option):-
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
    read_column(Column),
    check_column(Column),
    read_row(Row),
    write(Column),write(' '),write(Row),
    check_row(Row,NRow).

read_ball_from_move(Player,Row,Column,NRow):-
    write('\nPlease select from where you want to move a ball\n'),
    read_column(Column),
    check_column(Column),
    read_row(Row),
    write(Column),write(' '),write(Row),nl,
    check_row(Row,NRow).

read_ball_to_move(Player,Row,Column,NRow):-
    write('\nPlease select to where you want to move the ball\n'),
    read_column(Column),
    check_column(Column),
    read_row(Row),
    write(Column),write(' '),write(Row),nl.
    /*check_row(Row,NRow).*/



read_column(Column):-
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
    check_row(Row,NRow).


letter_to_number('A',0).
letter_to_number('B',1).
letter_to_number('C',2).
letter_to_number('D',3).
letter_to_number('E',4).







    

