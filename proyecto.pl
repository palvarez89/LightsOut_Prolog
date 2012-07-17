autor('Pedro Alvarez Piedehierro').



itocoord(L,I,F,C)	:-	F is (((I-1)//L)+1),
					C is (((I-1)mod L)+1).

					
					
lights(N,LEncendidas, LMarcadas)	:- 	generarPosibles(N, 1, LMarcadas), 
										probarsolucion(N,LEncendidas,LMarcadas).
 
generarPosibles(N, M, []):- M is (N*N)+1, !.

generarPosibles(N, M, LCombinacion):-	M1 is M+1,
									generarPosibles(N, M1, LCombinacion).
											
generarPosibles(N, M, [Nueva|LCombinacion]):-	M1 is M+1,
											generarPosibles(N, M1, LCombinacion),
											itocoord(N,M,F,C),
											Nueva = casilla(F,C).

													

/*OPERACIONES CON LISTAS*/

buscar(X, [L|_])	:-	L = X, !.
buscar(X, [L|Lista])	:-	L \= X, buscar(X, Lista).

borrar([],_,[]).
borrar([L|Lista], X, Lista)	:-	L=X, !.
borrar([L|Lista], X, [L|Lista2])	:-	borrar(Lista,X,Lista2).

insertar(Lista, X, [X|Lista]).
/*-----------------------------------------------------------------*/


casillavalida(N,casilla(F,C))	:-	F > 0, F < N+1, C > 0, C < N+1.



modificar(C, LEncendidas, LEncendidas2)	:-	buscar(C, LEncendidas),!, borrar(LEncendidas, C, LEncendidas2).
modificar(C, LEncendidas, LEncendidas2)	:-	insertar(LEncendidas,C,LEncendidas2).
												

activarDesactivarCasilla(N,C, LEncendidas, LEncendidas2)	:- 	casillavalida(N,C),!,
																modificar(C, LEncendidas, LEncendidas2).
activarDesactivarCasilla(_,_,X,X).



cambiar(N, casilla(F,C), LEncendidas, LEncendidasR)	:-	casillavalida(N,casilla(F,C)),
														F1 is F+1,
														activarDesactivarCasilla(N,casilla(F1,C), LEncendidas,LEncendidas1),
														
														F2 is F-1,
														activarDesactivarCasilla(N,casilla(F2,C), LEncendidas1,LEncendidas2),

														C1 is C+1,
														activarDesactivarCasilla(N,casilla(F,C1), LEncendidas2,LEncendidas3),

														C2 is C-1,
														activarDesactivarCasilla(N,casilla(F,C2), LEncendidas3,LEncendidas4),
														
														activarDesactivarCasilla(N,casilla(F,C), LEncendidas4,LEncendidasR).
														
														
														


probarsolucion(_, [], [])	:-	!.
probarsolucion(N, LEncendidas, [L|LMarcadas])	:-	cambiar(N,L,LEncendidas, LEncendidas2),
													probarsolucion(N,LEncendidas2,LMarcadas).

													
prueba(5,I)	:-	lights(5, [casilla(2,2), casilla(2,4), casilla(4,1), casilla(4,2), casilla(4,4), casilla(4,5)], I).
prueba(3,I) :-	lights(3, [casilla(1,2),casilla(2,1),casilla(2,2)], I).
prueba(2,I) :-	lights(2, [casilla(1,2),casilla(2,1),casilla(2,2)], I).
prueba(4,I)	:-	lights(4, [casilla(2,1),casilla(2,2),casilla(3,1),casilla(3,3),casilla(3,4),casilla(4,3),casilla(4,4)], I).