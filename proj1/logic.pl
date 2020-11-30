
%verifica se o anel pode ser adicionado, verificando se não há nenhuma bola nessa casa
check_add_ring(GameState,Row,Column,Rings,Bool):-
    get_ball(Column, Row, Ball, GameState),
    check_add_ring_decision(GameState,Row,Column,Ball,Rings,Bool).

%não há nenhuma bola, pode ser adicionado
check_add_ring_decision(GameState,Row,Column,'empty',Rings,true).

%há uma bola na casa. não pode ser adicionad
check_add_ring_decision(GameState,Row,Column,'black_ball',Rings,false):-
    write('\nYou cant add a ring there. There is a ball'),
    fail.

%há uma bola na casa. não pode ser adicionado
check_add_ring_decision(GameState,Row,Column,'white_ball',Rings,false):-
    write('\nYou cant add a ring there. There is a ball\n'),
    fail.

%adiciona o anel, recebe os aneis da casa, descobre o o index do anel do topo e adiciona em cima
add_ring(GameState,Player,Row,Column,RingsNumber,NewRingsNumber,NewGameState):-
    get_rings(Column, Row, Rings, Ball, GameState),
    get_top_ring_index(Rings,0,Index),
    nl,
    replace_ring(GameState,Player,Row,Column,Ball,Rings,Index,NewGameState),
    NewRingsNumber is RingsNumber - 1.

%verifica se um anel pode ser removido, ou sejam que não tem bola no topo
check_remove_ring(Player,GameState,Row,Column,Bool):-
  get_ball(Column, Row, Ball, GameState),
  get_top_ring(Row, Column, TopRing, GameState),
  check_remove_ring_decision(Player,GameState,Row,Column,Ball,TopRing,Bool).

check_remove_ring_decision(Player,GameState,Row,Column,'black_ball',TopRing,false):-
  write('\nYou cant move a ring from here. There is a black ball'),
  fail.

check_remove_ring_decision(Player,GameState,Row,Column,'white_ball',TopRing,false):-
  write('\nYou cant move a ring from here. There is a white ball'),
  fail.

check_remove_ring_decision('white',GameState,Row,Column,'empty','black_ring',false):-
  write('\nYou cant move a ring from here. Top ring is black'),
  fail.

check_remove_ring_decision('black',GameState,Row,Column,'empty','white_ring',false):-
  write('\nYou cant move a ring from here. Top ring is white'),
  fail.

check_remove_ring_decision(Player,GameState,Row,Column,'empty','empty',false):-
  write('\nYou cant move a ring from here. There are no rings'),
  fail.

check_remove_ring_decision('white',_,_,_,'empty','white_ring',true).

check_remove_ring_decision('black',_,_,_,'empty','black_ring',true).

%remove o anel da celula, identifica o anel do topo, ve o index e remove-o 
remove_ring(GameState,Player,Row,Column,RingsNumber,NewGameState):-
    get_rings(Column, Row, Rings, Ball, GameState),
    get_top_ring_index(Rings,0,Index),
    replace_ring(GameState,'empty',Row,Column,Ball,Rings,Index,NewGameState).

%verifica se duas casas são a mesma casa
is_same(AuxR,AuxC,DestinationRow, DestinationColumn,Bool):-
    AuxR=DestinationRow,
    AuxC=DestinationColumn,
    Bool is 1.

is_same(_,_,_, _,0).

%verifica se pode fazer vaulting, descobre a direção de movimento, e faz um ciclo a percorrer as posições todas
can_vault(Row,Column, DestinationColumn, DestinationRow,Bool,GameState,Ball):-
    ball_to_color(Ball,Color),
    AuxC is Column,
    AuxR is Row,
    get_direction(Row,Column, DestinationColumn, DestinationRow,DirectionR,DirectionC),
    can_vault_cycle(AuxR,AuxC,DirectionR,DirectionC,1,1,Bool,GameState,DestinationRow,DestinationColumn).

%fim do ciclo, chegou à casa final
can_vault_cycle(AuxR,AuxC,_,_,_,_,Bool,_,LastRow,LastColumn):-
    AuxR=LastRow,
    AuxC=LastColumn,
    Bool is 1.

%ciclo de verificação de vaulting, percorre as casas até à casa final, verifica se há uma bola em todas as casas
%e verifica se pode recolocar cada uma dessas bolas
can_vault_cycle(Row,Column,DirectionR,DirectionC,First_white,First_black,Bool,GameState,LastRow,LastColumn):-
    AuxR is Row + DirectionR,
    AuxC is Column + DirectionC,
    get_ball(AuxC,AuxR,Ball,GameState),
    ball_to_color(Ball,Color),
    can_recolocate(Color,AuxR,AuxC,GameState,First_white,First_black,Bool1,LastRow,LastColumn,NFirst_white,NFirst_black),
    can_vault_cycle(AuxR,AuxC,DirectionR,DirectionC,NFirst_white,NFirst_black,Bool2,GameState,LastRow,LastColumn),
    Bool is Bool1*Bool2.

%efetua o vaulting, seguindo o mesmo processo que o predicado can_vault
vault(GameState,Row_from,Column_from,Row_to,Column_to,NewGameState,Player,Vault):-
    Vault>0,
    display_game(GameState,Player),
    get_ball(AuxC,AuxR,Ball,GameState),
    ball_to_color(Ball,Color),
    AuxC is Column_from,
    AuxR is Row_from,
    get_direction(Row_from,Column_from, Column_to, Row_to,DirectionR,DirectionC),
    vault_cycle(AuxR,AuxC,DirectionR,DirectionC,GameState,Row_to,Column_to,NewGameState),
    display_game(NewGameState,Player,Rings).

%Vault é 0, logo este movimento não é vaulting
vault(NewGameState,_Row_from,_Column_from,_Row_to,_Column_to,NGameState,_Player,Vault):-
    Vault is 0,
    NGameState = NewGameState.

%fim do ciclo, chegou à casa final
vault_cycle(AuxR,AuxC,_,_,_,_,Bool,_,LastRow,LastColumn):-
    AuxR=LastRow,
    AuxC=LastColumn.

%ciclo de efetuar o vaulting, para cada bola vai pedir ao jogador que as recoloque
vault_cycle(Row,Column,DirectionR,DirectionC,GameState,LastRow,LastColumn,NGameState):-
    AuxR is Row + DirectionR,
    AuxC is Column + DirectionC,
    is_same(AuxR,AuxC,LastRow,LastColumn,Bool),
    (Bool=:=0->
    (get_ball(AuxC,AuxR,Ball,GameState),
    ball_to_color(Ball,Color),
    recolocate(Color,AuxR,AuxC,GameState,LastRow,LastColumn,NewGameState),
    display_game(NewGameState,Player,Rings),
    vault_cycle(AuxR,AuxC,DirectionR,DirectionC,NewGameState,LastRow,LastColumn,NGameState));NGameState = GameState
    ).

%recoloca a bola, pedindo o input ao jogador
recolocate(Color,Row,Column,GameState,LastRow,LastColumn,NewGameState):-
    validateRow(AuxR,Row),
    nl,write('You are now moving the '),write(Color),write(' ball on '),write(Column),write(AuxR),nl,
    read_ball_to_move(Player,Column_to,Row_to),
    can_free_move(Color,GameState,Row_to,Column_to,Row,Column),
    move_ball(GameState,Row,Column,Row_to,Column_to,NewGameState,Color).

%verifica se pode movimentar uma bola livremente, sem as regras do jogo 
%apenas verifica se na casa final não há uma bola e o anel do topo é da cor da bola
can_free_move(Color,GameState,Row_to,Column_to,Row_from,Column_from):-
    get_top_ring(Row_to,Column_to,Ring,GameState),
    ring_to_color(Ring,Color_ring),
    Color_ring=Color,
    get_ball(Column_to,Row_to,Ball,GameState),
    Ball='empty'.

%não cumpre os requisitios de movimento
can_free_move(Color,GameState,Row_to,Column_to,Row_from,Column_from):-
    nl,write('Cant move there. Try again'),nl,
    read_ball_from_move(Player,Column_from,Row_from),
    read_ball_to_move(Player,Column_to,Row_to),
    can_free_move(Color,GameState,Row_to,Column_to,Row_from,Column_from).

%não se pode recolocar bolas na posição final
can_recolocate('empty',_,_,_GameState,_First_white,_First_black,1,_LastRow,_LastColumn,_NFirst_white,_NFirst_black).
can_recolocate('black',4,4,_GameState,_First_white,_First_black,0,_LastRow,_LastColumn,_NFirst_white,_NFirst_black).
can_recolocate('black',4,3,_GameState,_First_white,_First_black,0,_LastRow,_LastColumn,_NFirst_white,_NFirst_black).
can_recolocate('black',3,4,_GameState,_First_white,_First_black,0,_LastRow,_LastColumn,_NFirst_white,_NFirst_black).

can_recolocate('white',0,0,_GameState,_First_white,_First_black,0,_LastRow,_LastColumn,_NFirst_white,_NFirst_black).
can_recolocate('white',0,1,_GameState,_First_white,_First_black,0,_LastRow,_LastColumn,_NFirst_white,_NFirst_black).
can_recolocate('white',1,0,_GameState,_First_white,_First_black,0,_LastRow,_LastColumn,_NFirst_white,_NFirst_black).

%se a bola a recolocar não é nem a primeira bola preta a ser recolocada nem a primeira bola branca
%a ser recolocada nesta jogada, tem sempre o lugar da bola anterior, não é preciso verificação
can_recolocate('black',AuxR,AuxC,_GameState,_First_white,0,1,_LastRow,_LastColumn).
can_recolocate('white',AuxR,AuxC,_GameState,0,_First_black,1,_LastRow,_LastColumn).


%verifica se pode recolocar, ou seja, se a lista de soluções do findall tiver mais que 0 elementos, sem contar com a casa final
can_recolocate(Color,_AuxR,_AuxC,GameState,First_white,First_black,Bool,LastRow,LastColumn,NFirst_white,NFirst_black):-
    findall([Column,Row], empty_ring_color(Column, Row, GameState,Color),L),
    length(L,Bool1),
    is_first_member(LastRow,LastColumn,L,BoolAux),
    Bool is Bool1-BoolAux,
    color_to_first(Color,First_white,First_black,NFirst_white,NFirst_black).

%verifica se a ultima celula é o primeiro membro da lista do findall
is_first_member(_,_,[],0).
is_first_member(FirstRow,FirstColumn,[[A,B]|T],Bool):-
    ([A,B]=[FirstColumn,FirstRow] -> Bool is 1;Bool is 0).

%a primeira bola branca foi recolocada 
color_to_first('white',First_white,_,NFirst_white,_NFirst_black):-
NFirst_white is 0.

%a primeira bola preta foi recolocada
color_to_first('black',_,First_black,_NFirst_white,NFirst_black):-
NFirst_black is 0.

color_to_first('empty',_,_First_black,_NFirst_white,_NFirst_black).

%verifica se uma determinada casa tem uma bola 'empty' e um anel de cor Color
empty_ring_color(Column, Row, GameState,Color):-
    get_ball(Column, Row, 'empty', GameState),
    ring_to_color(Ring,Color),
    get_top_ring(Row, Column, Ring, GameState).


%verifica se pode ser efetuado o movimento da bola,
%verificando se sao casas adjacentes, se a casa final não tem bola, se a casa final tem um anel da cor da bola
can_move(GameState,Player,Row,Column, DestinationRow, DestinationColumn,Bool,Vault):-
    is_same(Row,Column, DestinationRow, DestinationColumn,Bool1_aux),
    (Bool1_aux=:=0 -> Bool1 is 1; Bool1 is 0),
    is_adjacent(Row, DestinationRow, Bool2),
    is_adjacent(Column, DestinationColumn, Bool3),
    get_ball(Column, Row, Ball, GameState),
    get_ball(DestinationColumn, DestinationRow, FinalBall, GameState),
    is_empty(FinalBall,Bool6),
    ball_to_color(Ball,Color),
    compare_color(Color,Player,Bool4),
    get_top_ring( DestinationRow,DestinationColumn, Ring, GameState),
    ring_to_color(Ring,Color),
    compare_color(Color,Player,Bool5),
    Bool is Bool1*Bool2*Bool3*Bool4*Bool5*Bool6,
    (Bool>0->Vault is 0;true).

%o can_move anterior falhou, por isso tenta com vaulting
can_move(GameState,Player,Row,Column, DestinationRow, DestinationColumn,Bool,Vault):-
    Bool1 is 1,
    get_ball(Column, Row, Ball, GameState),
    get_ball(DestinationColumn, DestinationRow, FinalBall, GameState),
    is_empty(FinalBall,Bool6),
    ball_to_color(Ball,Color),
    compare_color(Color,Player,Value),
    Bool2 is Bool1*Value,
    get_top_ring( DestinationRow,DestinationColumn, Ring, GameState),
    ring_to_color(Ring,Color),
    compare_color(Color,Player,Value),
    Bool3 is Bool2*Value,
    can_vault(Row,Column, DestinationColumn, DestinationRow,Bool_aux,GameState,Ball),
    Bool4 is Bool3*Bool_aux*Bool6,
    (Bool4>=1 -> Bool is 1;Bool is 0),
    Vault is Bool.

%efetua o movimento da bola, substituindo na celula inicial por uma bola vazia e na celula final pela bola
move_ball(GameState,Row_from,Column_from,Row_to,Column_to,NewGameState,Player):-
    replace_ball(GameState,Row_from,Column_from,'empty',NGameState),
    ball_to_color(Ball,Player),
    replace_ball(NGameState,Row_to,Column_to,Ball,NewGameState).

%verifica se dois pontos são adjacentes
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

is_adjacent(_,_,0).

%verifica se uma bola se pode mover a partir de uma casa
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

%verifica se uma bola se pode mover para uma casa
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

evaluate(GameState,Player,Score):-
    ball_to_color(Ball,Player),
    findall([Column,Row],get_ball(Column,Row,Ball,GameState),Ball_Positions),
    evaluate_balls_cycle(Player,Score1,Ball_Positions),

    ring_to_color(Ring,Player),

    findall([Column,Row],get_top_ring(Row,Column,Ring,GameState),Ring_Positions),
    evaluate_rings_cycle(GameState,Player,Score2,Ring_Positions,Ball_Positions),

    Score is Score1+Score2.




evaluate_balls_cycle(_Player,0,[]).

evaluate_balls_cycle(Player,Score,[Coord|T]):-
    [Column,Row]=Coord,
    distance_to_corner(Column,Row,Player,Distance),
    evaluate_balls_cycle(Player,Score1,T),
    Score is Score1-Distance.

evaluate_rings_cycle(_GameState,_Player,0,[],_Ball_Positions).
evaluate_rings_cycle(GameState,Player,Score,[[Column_Ring,Row_Ring]|T],Ball_Positions):-

   distance_to_corner(Column_Ring,Row_Ring,Player,Distance),
   evaluate_rings_subcycle(Column_Ring,Row_Ring,Ball_Positions,Adjacent_balls),

   evaluate_rings_cycle(GameState,Player,Score1,T,Ball_Positions),

   Score is Score1+(Adjacent_balls*3)-Distance.



evaluate_rings_subcycle(_Column_Ring,_Row_Ring,[],0).
evaluate_rings_subcycle(Column_Ring,Row_Ring,[[Column_Ball,Row_Ball]|T],Adjacent_balls):-
    are_adjacent(Column_Ring,Row_Ring,Column_Ball,Row_Ball,Bool),
    evaluate_rings_subcycle(Column_Ring,Row_Ring,T,Adjacent_balls1),
    Adjacent_balls is Adjacent_balls1+Bool.


are_adjacent(Column1,Row1,Column2,Row2,Bool):-
    is_adjacent(Column1,Column2,Bool1),
    is_adjacent(Row1,Row2,Bool2),
    Bool is Bool1*Bool2.



distance_to_corner(Column,Row,'white',Distance):-
    D1 is 4-Column,
    D2 is 4-Row,
    (D1>D2->Distance is D1;Distance is D2).

distance_to_corner(Column,Row,'black',Distance):-
    D1 is Column,
    D2 is Row,
    (D1>D2->Distance is D1;Distance is D2).


get_easy_bot_decision_rings(GameState,Player,Column,Row,Possibilities):-
    get_rings_next_to_balls(GameState,Player,Possibilities,NPossibilities),
    get_Column_Row_bot(Column,Row,NPossibilities).

get_Column_Row_bot(Column,Row,[H|T]):-
    [Column,Row] = H.



get_rings_next_to_balls(GameState,Player,Possibilities,NPossibilities):-

    ball_to_color(Ball,Player),
    findall([Column,Row],get_ball(Column,Row,Ball,GameState),Ball_Positions),

    ring_to_color(Ring,Player),
    findall([Column1,Row1],is_adjacent_to_ball(Column1,Row1,GameState,Ball_Positions,1),Adjacent_balls),

    findall([Column,Row],(member([Column,Row],Possibilities),member([Column,Row],Adjacent_balls)),NPossibilities).
    



is_adjacent_to_ball(Column,Row,GameState,Ball_Positions,Bool):-
    is_adjacent_to_ball_cycle(Column,Row,GameState,Ball_Positions,Bool).
    
is_adjacent_to_ball_cycle(_Column,_Row,_GameState,[],1).
is_adjacent_to_ball_cycle(Column,Row,GameState,[[Column_Ball,Row_Ball]|T],Bool):-
    are_adjacent(Column,Row,Column_Ball,Row_Ball,Bool_aux),
    is_adjacent_to_ball_cycle(Column,Row,GameState,T,Bool1),
    Bool is Bool1*Bool_aux.




  