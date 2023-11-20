cor(amarela).
cor(azul).
cor(branca).
cor(verde).
cor(vermelha).

dono(cesar).
dono(fagner).
dono(luciano).
dono(roger).
dono(tulio).

montadora(alema).
montadora(americana).
montadora(chinesa).
montadora(japonesa).
montadora(italiana).

placa(aaa-1111).
placa(bbb-2222).
placa(ccc-3333).
placa(ddd-4444).
placa(eee-5555).

km(10000).
km(20000).
km(30000).
km(40000).
km(50000).

desenho(caveira).
desenho(fenix).
desenho(guitarra).
desenho(vampiro).
desenho(serpente).


%X está à ao lado de Y
aoLado(X,Y,Lista) :- nextto(X,Y,Lista);nextto(Y,X,Lista).
                       
%X está à esquerda de Y (diretamente à esquerda)
aEsquerda(X,Y,Lista) :- nth0(IndexX,Lista,X), 
                        nth0(IndexY,Lista,Y), 
                        IndexY =:= IndexX + 1.
                        
%X está à direita de Y (diretamente à direita)
aDireita(X,Y,Lista) :- aEsquerda(Y,X,Lista). 

%X está no canto se ele é o primeiro ou o último da lista
noCanto(X,Lista) :- last(Lista,X).
noCanto(X,[X|_]).

%X está em algum lugar à esquerda de Y
estaNaEsquerda(X, Y, Lista) :- 
	nth0(IndexX, Lista, X),
	nth0(IndexY, Lista, Y),
	IndexX < IndexY.

%X está em algum lugar à direita de Y
estaNaDireita(X, Y, Lista) :- estaNaEsquerda(Y, X, Lista).

%X está entre Y e Z, em algum lugar da lista
estaEntre(X, Y, Z, Lista) :-
    nth0(IndexY, Lista, Y),
    nth0(IndexZ, Lista, Z),
    nth0(IndexX, Lista, X),
    IndexX > IndexY,
    IndexX < IndexZ.

todosDiferentes([]).
todosDiferentes([H|T]) :- not(member(H,T)), todosDiferentes(T).


solucao(ListaSolucao) :- 

    ListaSolucao = [
    moto(Cor1, Dono1, Montadora1, Placa1, Km1, Desenho1),
	moto(Cor2, Dono2, Montadora2, Placa2, Km2, Desenho2),
	moto(Cor3, Dono3, Montadora3, Placa3, Km3, Desenho3),
	moto(Cor4, Dono4, Montadora4, Placa4, Km4, Desenho4),
	moto(Cor5, Dono5, Montadora5, Placa5, Km5, Desenho5)
    ],

	%A moto Vermelha está exatamente à esquerda da moto menos rodada.
	aEsquerda(moto(vermelha, _, _, _, _, _), moto(_, _, _, _, 10000, _), ListaSolucao),

	%A moto que tem 10 mil km está ao lado da moto do Túlio.
	aoLado(moto(_, _, _, _, 10000, _), moto(_, tulio, _, _, _, _), ListaSolucao),

	%A moto que tem o desenho de uma Guitarra está exatamente à esquerda da moto cuja placa é CCC-3333.
	aEsquerda(moto(_, _, _, _, _, guitarra), moto(_, _, _, ccc-3333, _, _), ListaSolucao),

	%A moto de 50 mil km está ao lado da moto do Roger.
	aoLado(moto(_, _, _, _, 50000, _), moto(_, roger, _, _, _, _), ListaSolucao),

	%Na quinta posição se encontra a moto de placa BBB-2222.
	Placa5 = bbb-2222,

	%A moto de placa DDD-4444 está exatamente à direita da moto que tem o desenho de uma Serpente.
	aDireita(moto(_, _, _, ddd-4444, _, _), moto(_, _, _, _, _, serpente), ListaSolucao),

	%A moto Vermelha está em algum lugar à esquerda da moto do Túlio.
	estaNaEsquerda(moto(vermelha, _, _, _, _, _), moto(_, tulio, _, _, _, _), ListaSolucao),

	%A moto de 40 mil km está exatamente à direita da moto Verde.
	aDireita(moto(_, _, _, _, 40000, _), moto(verde, _, _, _, _, _), ListaSolucao),

	%O desenho de Caveira está na moto localizada em uma das pontas.
	noCanto(moto(_, _, _, _, _, caveira), ListaSolucao),

	%César é o dono da moto de placa CCC-3333.
	member(moto(_, cesar, _, ccc-3333, _, _), ListaSolucao),

	%A moto que tem o desenho de uma Fênix está exatamente à esquerda da moto que tem 30 mil km.
	aEsquerda(moto(_, _, _, _, _, fenix), moto(_, _, _, _, 30000, _), ListaSolucao),

	%A moto da montadora Japonesa está em algum lugar à direita da moto Vermelha.
	estaNaDireita(moto(_, _, japonesa, _, _, _), moto(vermelha, _, _, _, _, _), ListaSolucao),

	%Em uma das pontas está a moto de 20 mil km.
	noCanto(moto(_, _, _, _, 20000, _), ListaSolucao),

	%A moto Verde está em algum lugar à esquerda da moto da montadora Alemã.
	estaNaEsquerda(moto(verde, _, _, _, _, _), moto(_, _, alema, _, _, _), ListaSolucao),

	%O desenho de Vampiro está na moto localizada na quarta posição.
	Desenho4 = vampiro,

	%A moto Branca está exatamente à direita da moto Amarela.
	aDireita(moto(branca, _, _, _, _, _), moto(amarela, _, _, _, _, _), ListaSolucao),

	%Na quarta posição está a moto da montadora Italiana.
	Montadora4 = italiana,

	% A moto Verde está em algum lugar entre a moto do Fágner e a moto que tem o desenho de uma Guitarra, nessa ordem.
	estaEntre(moto(verde, _, _, _, _, _), moto(_, fagner, _, _, _, _), moto(_, _, _, _, _, guitarra), ListaSolucao),

	%A moto Amarela está ao lado da moto do Túlio.
	aoLado(moto(amarela, _, _, _, _, _), moto(_, tulio, _, _, _, _), ListaSolucao),

	%A moto cuja placa é AAA-1111 está exatamente à direita da moto da montadora Chinesa.
	aDireita(moto(_, _, _, aaa-1111, _, _), moto(_, _, chinesa, _, _, _), ListaSolucao),


 %Testa todas as possibilidades...
    dono(Dono1), dono(Dono2), dono(Dono3), dono(Dono4), dono(Dono5),
    todosDiferentes([Dono1, Dono2, Dono3, Dono4, Dono5]),
	
	cor(Cor1), cor(Cor2), cor(Cor3), cor(Cor4), cor(Cor5),
    todosDiferentes([Cor1, Cor2, Cor3, Cor4, Cor5]),

    montadora(Montadora1), montadora(Montadora2), montadora(Montadora3), montadora(Montadora4), montadora(Montadora5),
    todosDiferentes([Montadora1, Montadora2, Montadora3, Montadora4, Montadora5]),

    placa(Placa1), placa(Placa2), placa(Placa3), placa(Placa4), placa(Placa5),
    todosDiferentes([Placa1, Placa2, Placa3, Placa4, Placa5]),

    km(Km1), km(Km2), km(Km3), km(Km4), km(Km5),
    todosDiferentes([Km1, Km2, Km3, Km4, Km5]),

    desenho(Desenho1), desenho(Desenho2), desenho(Desenho3), desenho(Desenho4), desenho(Desenho5),
    todosDiferentes([Desenho1, Desenho2, Desenho3, Desenho4, Desenho5]).
    