# Mitsudomoe
## PLOG_TP1_AV_T7_Mitsudomoe2

| Name             | Number    | E-Mail             |
| ---------------- | --------- | ------------------ |
| Luís Assunção    | 201806140 |up201806140@fe.up.pt|
| João Rocha       | 201806261 |up201806261@fe.up.pt|


## Instalação e execução
Para executar o jogo é preciso na consola do sicstus consultar o ficheiro mitsudomoe.pl, com o comando consult('mitsudomoe.pl). Após isso, executa-se o predicado play/0 e o jogo começa.


## O jogo

[Regras](https://www.nestorgames.com/rulebooks/MITSUDOMOE_EN.pdf)

### Conceito
Mitsudomoe é um jogo de 2 a 4 jogadores (neste caso 2) cujo objetivo é o jogador colocar as suas peças no outro lado do tabuleiro mais rapidamente que o adversário. 

### Início
Inicialmente cada jogador tem 3 bolas nas suas posições iniciais e cada bola sobre um anel da sua cor (branco ou preto) e cada jogador tem um total de 8 anéis.

### Jogada
Uma jogada é dividida em dois passos:
- Adicionar ou mover um anel. Pode adicionar ou mover o anel para qualquer casa do tabuleiro desde que não haja lá uma bola, mesmo que isso implique fazer uma pilha de anéis.
- Mover uma bola (há duas formas de mover uma bola)
    - Mover uma bola para cima de um anel da mesma cor num espaço adjacente, seja este ortogonal ou diagonal.
    - Mover uma bola por cima de uma fila de bolas até ao outro lado, recolocando-as (vaulting, ver em baixo).

### Vaulting
Consiste na jogada onde se movimenta a bola, numa linha reta por cima de um conjunto sucessivo de bolas próprias ou adversárias até chegar a uma casa com um anel da cor respetiva. No final desta jogada as bolas que foram "vaulted" serão recolocadas pelo jogador que efetuou o vaulting. As bolas têm de ser recolocadas para uma casa que tenha um anel por baixo. Caso não possam ser recolocadas, o vaulting não é possível.

### Factos gerais do jogo
- Uma bola quando chega à posição final nunca de lá sai
- Uma bola tem sempre um anel da mesma cor por baixo
- Nenhuma peça do tabuleiro abandona o tabuleiro



## Lógica do Jogo

### Representação do jogo
O tabuleiro é representado através de uma lista de listas de listas (linhas*colunas*stack). Em cada par linha/coluna há uma stack cuja cabeça é a bola (white_ball, black_ball ou empty) e 10 espaços para anéis colocados numa stack (white_ring, black_ring, empty). É apresentado também qual o jogador a jogar e quantos anéis tem disponíveis para adicionar.
Visualmente, cada célula é constituída por um retêngulo 3*5 cujo centro é a bola, representada por W ou B consoante a cor (White or Black), circundada por anéis, representados por w e b consoante a cor (white or black). O anel do canto superior esquerdo é considerado o topo da stack, sendo que só é ocupado se estiverem 10 anéis na stack (altamente improvável). A partir daí, a ordem dos anéis baixa em sentido horário até se chegar à casa debaixo do canto superior esquerdo, que representa a 10ª posição da stack, ou seja, o anel do fundo. Esta posição estará obrigatoriamente preenchida se houver um uma bola nessa casa.

### Vizualização do estado do jogo
Foi criado um sistema de menus onde o utilizador pode selecionar se pretende jogar com 2 pessoas, duas pessoas e um bot ou dois bots. Nesse menu também pode decidir sair do jogo.
Os jogo é controlado com inputs númericos, por exemplo na escolha de adicionar ou mexer um anel, ou por inputs alfanuméricos, como é o caso das jogadas, caracterizadas por uma coluna 0-4 e por uma linha 'A'-'E'.

### Execução das jogadas
As jogadas são lidas como um conjunto coluna linha, como descrito no ponto anterior, inseridos separadamente. Numa fase inicial apenas é verificado se esses valores se encontram dentro dos limites do tabuleiro.
No caso do nosso Mitsudomoe há 4 tipos de jogadas diferentes, adicionar um anel, mover um anel, mover uma bola e recolocar uma bola. Para se adicionar uma bola é preciso fornecer as coordenadas da bola e as coordenadas de destino. No caso de adicionar um anel só é preciso forncer as coordenadas de destino. O caso de mover um anel é semelhante ao de mover uma bola e o de recolocar uma bola só necessita de coordenadas de destino. Obviamente os 4 tipos são processados de forma diferente para serem validados e jogados, de modo que apenas um predicado valid_moves ou move não é suficiente. Por esse motivo, temos os predicados move_ball, recolocate, move_ring, add_ring e valid_moves_ball, valid_moves_ring, valid_moves_add_ring, valid_moves_recolocate.

- adicionar anel: Verifica-se se o jogador tem mais que 0 anéis e se a casa onde tenta adicionar o anel não tem nenhuma bola, com o predicado get_ball. 
- mover anel: Verifica-se que a casa inicial tem um anel da cor do jogador. Se tiver segue o mesmo protocolo que adicionar o anel.
- mover bola: Verifica-se se a casa de origem tem uma bola da cor do jogador. Verifica-se se a casa final tem o anel do topo da cor do jogador. Verifica-se se a casa de destino é adjacente à bola. Se não for é chamado o predicado can_vault para percorrer todas as casas da casa inicial à casa final, e verifica se essa casa tem uma bola e se essa bola pode ser recolocada, através de um findall de todas as casas do tabuleiro com bola 'empty' e anel de topo de cor da bola a ser recolocada. Caso isto se suceda, troca-se a bola na posição inicial por uma bola 'empty' e na posição final troca-se a bola 'empty' pela bola movimentada. No caso do vaulting depois é pedido ao jogador para recolocar todas as bolas vaulted.
- recolocar: O jogador insere a casa para onde a bola é recolocada e é verificado se aquela casa tem uma "bola" empty e o anel de topo é da cor da bola recolocada.

## Final do Jogo
A verificação de final de jogo é realida com um predicado que compara o estado atual com os estados finais, isto é, com os dois tipos de estados possíveis de fim de jogo, onde o jogador branco tem todas as suas bolas em casas finais ou o jogador preto tem todas as suas bolas em casas finais.
Tmabém é possível que o jogo chegue ao fim se não for encontrada nenhuma jogada possível quer para os anéis quer para as bolas.

## Avaliação do tabuleiro 
O tabuleiro vale mais quanto mais perto estiverem as bolas do jogador de casas finais. Cada casa final já conseguida aumenta o valor do tabuleiro. Os anéis são valorizados se estiverem perto de bolas da sua cor, preferencialmente mais próximo de casas finais.

## Jogada de computador
Para a escolha da jogada do computador é efetuado um findall de todas as jogadas possíveis e respetivo valor. O computador escolhe a que tiver pontuação mais alta

## Conclusões 
O Mitsudomoe jogo é um jogo muito complexo, com muitas dinâmicas, o que apresentou bastantes problemas no seu desensenvolvimento. Reconhecemos algumas limitações do trabalho, nomeadamente blabla, que poderiam ser melhoradas da seguinte forma blabla.