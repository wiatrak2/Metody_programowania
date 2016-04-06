%neg/2 - służy do znajdowania negacji danego literału.
neg(~X, X) :- !.
neg(X, ~X).

%lit/1 - sprawdza czy X jest literałem.
lit(X) :-
		atom(X).
lit(~X) :- 
		atom(X).

%get_var/2 - zwraca pierwszy literał danej klauzuli.
get_var(C v _, C) :-
		lit(C).

%sel_alt/2 - zwraca klauzulę bez pierwszego literału.
sel_alt(C v D, D) :-
		lit(C).

%cl2set/2 - zamienia klauzulę na listę zawierającą zbiór jej literałów.
cl2set(X, L) :-
		cl2list(X, L1), sort(L1, L).

%cl2list/2 - zamienia klauzulę na listę jej literałów.
cl2list(X, [X]) :-
		lit(X), !.
cl2list(X, [H|T]) :-
		get_var(X, H), sel_alt(X, X1), cl2list(X1, T).

%list_cl/2 - zamienia listę klauzul na listę list literałów tych klauzul.
get_clauses_list([X], [L]) :-
		cl2set(X, L), !.
get_clauses_list([H|T], [H1|T1]) :-
		cl2set(H, H1), get_clauses_list(T, T1).

%iter/3 iter(?List, ?ListFirst, ?ListRest) - dla listy List zwraca jej pierwszy element ListFirst oraz resztę elementów ListRest. Możliwość nawrotu 
iter([L], L, []) :- !.
iter([H|T], H, T).
iter([_|T], X, Y) :-
		iter(T, X, Y).
		
%find_op/1 powodzi się gdy w liście nie występuje literał i jego zaprzeczenie.
find_op([]) :- !.
find_op([H|T]) :-
		neg(H, H1),
		\+ member(H1, T),
		find_op(T).

prove(Clauses, Proof) :-
		get_clauses_list(Clauses, C1), sort(C1, C2), deduce(C2, P1), prep_to_write(P1, Proof).

%deduce/2 - główny silnik programu, za pomocą listy klauzul L wyprowadza dowód sprzeczności w postaci listy Res.		
deduce(L, Res) :- 
		make_axiom_list(L, AxList),
		get_axiom_num(AxList, Num),
		deduce(L, Res, AxList, Num).

deduce([[]|_], X, X, _) :- !.
deduce([H|T], Res, Acc, Num) :-
		iter([H|T], HeadList, TailList),
		iter(HeadList, FirstElem, _),
		neg(FirstElem, NegElem),
		iter(TailList, FirstClause, _),
		member(NegElem, FirstClause),
		select(FirstElem, HeadList, Resol1),
		select(NegElem, FirstClause, Resol2),
		clause_append(Resol1, Resol2, NewResol),
		find_op(NewResol),
		\+ member(NewResol, [H|T]),
		NewNum is Num + 1,
		get_resol_num(NewResol, HeadList, FirstClause, Acc, NewNum, NewAcc),
		deduce([NewResol, H|T], Res, NewAcc, NewNum).

%clause_append/3 - zwraca połączone i posortwoane dwie listy.
clause_append(L1, L2, Res) :-
		clause_append(L1, L2, [], Res1), sort(Res1, Res), !.

clause_append([], [], Res, Res) :- !.
clause_append([], [H|T], Acc, Res) :-
		clause_append([], T, [H|Acc], Res).
clause_append([H|T], L, Acc, Res)	:-
		clause_append(T, L, [H|Acc], Res).

%make_axiom_list/2 - dla podanej listy zawierającej listy oznaczające klauzule tworzy listę słóżącą do wypisania wyniku. Element listy ma postać:[[Klauzla], Numer, (axiom)].
make_axiom_list(AxList, Res) :-
		make_axiom_list(AxList, 1, Res, []).

make_axiom_list([], _, Res, Res) :- !.
make_axiom_list([H|T], Num, Res, Acc) :-
		NewNum is Num + 1,
		make_axiom_list(T, NewNum, Res, [[H, Num, (axiom)] | Acc]).

%get_axiom_num/2 zwraca numer ostatniej klauzuli oznaczonej jako axiom.
get_axiom_num([[_,Num,_]|_], Num).

%get_clause_num/3 -znajduje numer Res klauzli Clause umieszczonej w liście NumList 
get_clause_num(Clause, NumList, Res) :-
		iter(NumList, [Clause, Res, _], _), !.

%get_resol_num/6 - do listy NumList dodaje nowy element będący rezolwentą klauzul Cl1 i Cl2, dodaje mu numer oraz jego pochodzenie, zwraca Res - listę z nowym elementem na poczatku.
get_resol_num(Resol, Cl1, Cl2, NumList, CurrentNum, Res) :-
		get_clause_num(Cl1, NumList, Num1),
		get_clause_num(Cl2, NumList, Num2),
		Res = [[Resol, CurrentNum, (Num1, Num2)] | NumList], !.

%prep_to_write/2 - z trzymanej listy klauzul tworzy listę w postaci umożliwiającej wypisanie wyniku przy pomocy writeProof		
prep_to_write(List, Res) :-
		prep_to_write(List, Res, []), !.

prep_to_write([], Res, Res) :- !.
prep_to_write(List, Res, Acc) :-
		iter(List, [[], _, Origin], Rest),
		prep_to_write(Rest, Res, [([], (Origin))|Acc]).
prep_to_write(List, Res, Acc) :-
		iter(List, [Clause, _, Origin], Rest),
		cl2list(Cl, Clause),
		prep_to_write(Rest, Res, [(Cl, (Origin))|Acc]).
