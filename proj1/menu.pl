
play:-
    printMenu,
    repeat,
    getInput(Input),
    (call(manageInput(Input)) -> true, !; fail).

getInput(Input) :-
  askMenuOption,
  read(Input).

manageInput(1) :-
    startGame('P','P'),
    play.

manageInput(2) :-
    startGame('P','C'),
    play.

manageInput(3) :-
    startGame('C','C'),
    play.

manageInput(4) :-
    write('valid option!\n\n').

manageInput(0) :-
    write('\nExiting...\n\n').

manageInput(_Other) :-
    write('\nERROR: that option does not exist.\n\n'),
    fail.

printMenu :-
    nl,nl,
    write(' _______________________________________________________________________ '),nl,
    write('|                                                                       |'),nl,
    write('|                               MITSUDOMOE                              |'),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write('|                           Luis Andre Assuncao                         |'),nl,
    write('|                              Joao Paulo Rocha                         |'),nl,
    write('|               -----------------------------------------               |'),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write('|                          1. Player vs Player                          |'),nl,
    write('|                                                                       |'),nl,
    write('|                          2. Player vs Computer                        |'),nl,
    write('|                                                                       |'),nl,
	write('|                          3. Computer vs Computer                      |'),nl,
    write('|                                                                       |'),nl,
    write('|                          0. Exit                                      |'),nl,
    write('|                                                                       |'),nl,
    write('|                                                                       |'),nl,
    write(' _______________________________________________________________________ '),nl,nl,nl.

askMenuOption :-
    write('> Insert your option ').
