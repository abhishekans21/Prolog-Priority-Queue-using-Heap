%Authors: Abhishek Tiwari(B15238), Sandesh joshi(B15132)
%******************NOTE*********************************
%our tree is printed sideways, i.e. root of the tree 
%is printed with zero indentation
%*******************************************************

my_list([11,10,8,5,7,9,6]).



%Construct,Display Tree
construct(L,T) :- construct(L,T,nil,0).
construct([],T,T,_).
construct([N|Ns],T,T0,Counter) :- add1(N,T0,T1,Counter),construct(Ns,T,T1,Counter+1).

posi(0,[0]).
posi(1,[1]).
posi(Counter,X):-C1 is Counter//2, C2 is Counter mod 2,posi(C1,Y),append(Y,[C2],X).

add1(N,T0,T1,Counter):- ElemId is Counter + 1,posi(ElemId,[X|Xs]),add(N,T0,T1,Xs).


add(X, nil, node(X, nil, nil),[]).
add(X, node(Root, nil, nil), node(Root, node(X,nil,nil), nil),[0]).
add(X, node(Root, Left, nil), node(Root, Left, node(X,nil,nil)),[1]).


add(X, node(Root, L, R),node(Root, L1, R),[Y|Ys]) :- Y is 0, add(X, L, L1,Ys).
add(X, node(Root, L, R),node(Root, L, R1),[Y|Ys]) :- Y is 1, add(X, R, R1,Ys).

show( Tree)  :-
    show2( Tree, 0).

% show2( Tree, Indent): display Tree indented by Indent

show2( nil, _).

show2( node( X, nil, nil), Indent)  :-
    nl,
    Ind2 is Indent + 5,
    tab( Indent), write( X), nl,
    nl.
show2( node( X, Left, nil), Indent)  :-
    nl,
    Ind2 is Indent + 5,
    tab( Indent), write( X), nl,
    tab( Indent+2),write('\\'),
    nl,
    show2( Left, Ind2).

show2( node( X, nil, Right), Indent)  :-
    nl,
    Ind2 is Indent + 5,
    show2( Right, Ind2),
    tab( Indent+2),write('/'),nl,
    tab( Indent), write( X), nl,
    nl.
    
show2( node( X, Left, Right), Indent)  :-
    nl,
    Ind2 is Indent + 5,
    show2( Right, Ind2),
    tab( Indent+2),write('/'),nl,
    tab( Indent), write( X), nl,
    tab( Indent+2),write('\\'),
    nl,
    show2( Left, Ind2).




%Swap two elements
list_i_j_swapped(As,I,J,Cs) :-
   same_length(As,Cs),
   append(BeforeI,[AtI|PastI],As),
   append(BeforeI,[AtJ|PastI],Bs),
   append(BeforeJ,[AtJ|PastJ],Bs),
   append(BeforeJ,[AtI|PastJ],Cs),
   length(BeforeI,I),
   length(BeforeJ,J).



%Insertion in Priority Queue
insert([],X,X1):-	append([],[X],X1),
					nl,write('Inserting Element:'),
					write(X),
					show(node(X,nil, nil)),
					write('******************************************************************').
insert(Heap,X,Heap1):-	append(Heap,[X],L),
						length(L,S),heapify(L,S,Heap1),
						nl,write('Inserting Element:'),
						write(X),
						construct(Heap1,T),show(T),
						write('******************************************************************').

heapify(L,1,L).
heapify(L,0,L).
heapify(L,S,L2):- 	Pi is S//2,
					nth1(Pi, L,Parent), nth1(S,L,Current),
					Parent @< Current,
					S1 is S-1,Pi1 is Pi-1,
					list_i_j_swapped(L,S1,Pi1,L1),
					heapify(L1,Pi,L2).
heapify(L,S,L):- 	Pi is S//2,
					nth1(Pi, L,Parent), nth1(S,L,Current),
					Parent @>= Current.





%Extract Max-Deletion of top element from Priority Queue.

xtractmax([X|[]],[],X):-	nl,write('Extracting Max element:'),
							write(X),
							show(node(X,nil,nil)),
							write('******************************************************************').

extractmax(Heap,Heap1,X):-	swaplast(Heap,L,X),
							heapifytop(L,1,Heap1),
							construct(Heap1,T),
							nl,write('Extracting Max element:'),
							write(X),
							show(T),
							write('******************************************************************').

swaplast([Y|Ys],L,X):- X is Y, reverse(Ys,[Z|Zs]),reverse(Zs,W),append([Z],W,L).

heapifytop(L,Temp,L):-length(L,Last),Temp =< Last,Temp > Last//2.

heapifytop(L,S,L2):- 	LCi is S*2,
						length(L,Temp),
						LCi =:= Temp,
						nth1(LCi,L,LChild),
						nth1(S,L,Current),
						LChild < Current,
						heapifytop(L,LCi,L2).
heapifytop(L,S,L2):- 	LCi is S*2,
						length(L,Temp),
						LCi =:= Temp,
						nth1(LCi,L,LChild),
						nth1(S,L,Current),
						LChild > Current,
						S1 is S-1,LCi1 is LCi-1,
						list_i_j_swapped(L,S1,LCi1,L1),
						heapifytop(L1,LCi,L2).
heapifytop(L,S,L2):- 	LCi is S*2,
						length(L,Temp),
						LCi < Temp,
						nth1(LCi,L,LChild),
						nth1(S,L,Current),
						RCi is LCi +1,
						RCi =< Temp,nth1(RCi,L,RChild),
						RChild > LChild, RChild > Current,
						S1 is S-1,RCi1 is RCi-1,
						list_i_j_swapped(L,S1,RCi1,L1),
						heapifytop(L1,RCi,L2).
heapifytop(L,S,L2):- 	LCi is S*2,
						length(L,Temp),
						LCi < Temp,
						nth1(LCi,L,LChild),
						nth1(S,L,Current),
						RCi is LCi+1,
						RCi =< Temp,
						nth1(RCi,L,RChild),
						RChild < LChild, LChild > Current,
						S1 is S-1,LCi1 is LCi-1,
						list_i_j_swapped(L,S1,LCi1,L1),
						heapifytop(L1,LCi,L2).




%Utility Function
pushToQueue([], Heap, Heap).
pushToQueue([Z|Zs], Heap, Heap1):- insert(Heap, Z, Heap0), pushToQueue(Zs,Heap0,Heap1).




%Main function
main :-
    my_list(Z),
    pushToQueue(Z,[],Heap),
    nl,
    extractmax(Heap, Heap1, X).

