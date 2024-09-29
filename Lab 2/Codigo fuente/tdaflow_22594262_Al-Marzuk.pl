:- consult('tdaoption_22594262_Al-Marzuk.pl').

/*
 nombre: agregarSinDuplicados/3

 Descripci�n: Predicado que filtra los elementos de una lista, borrando
 los duplicados. Este se va a utilizar para eliminar las opciones
 duplicadas de un Flow. Esto se hace comprobando si el primer elemento
 de la lista no est� en la lista acumuladora, en ese caso lo
 agrega, y en caso contrario no lo agrega y avanza con el
 siguiente elemento

 Dominio: Lista a filtrar X Lista Acumuladora X Lista Final

 Metas Primarias: agregarSinDuplicados/3

 Metas secundarias: member/2
*/

agregarSinDuplicados([], Acc, Acc).

agregarSinDuplicados([Elemento|Resto], Acc, ListaSalida) :-
    \+ member(Elemento, Acc),
    agregarSinDuplicados(Resto, [Elemento|Acc], ListaSalida).

agregarSinDuplicados([Elemento|Resto], Acc, ListaSalida) :-
    member(Elemento, Acc),
    agregarSinDuplicados(Resto, Acc, ListaSalida).

/*
 Nombre: flowGetID/2

 Dominio: Flow, ID (IntegeR)

 Descripci�n: Entrega el ID del flujo
 */

flowGetID([ID, _, _], ID).

/*
 Nombre: flowGetOptions/2

 Dominio: Flow, Options

 Descripci�n: Entrega las opciones del flujo
 */

flowGetOptions([_, _, Options], Options).

/*
 Nombre: flowGetName/2

 Dominio: Flow, Name (String)

 Descripci�n: Entrega el nombre del flujo
*/

flowGetName([_, Name, _], Name).

/*
 Nombre: flowIdsFilter/3

 Dominio: Flow, Msg (String), List

 Descripci�n: Regla recursiva que lo que hace es explorar las opciones
 de un flujo en busca de la lista de keywords que contenga al mensaje,
 cuando la encuentra, devuelve una lista con el id del chatbot y flujo
 asociados a la opcion

 Recursion Usada: De cola

 Metas primarias: flowIdsFilter/3

 Metas secundarias: flowGetOptions/2, optionIdsFilter/3
*/

% Condici�n de parada, no hay m�s opciones en el flujo, devuelve una
% lista vac�a

flowIdsFilter(Flow, _, []) :-
    flowGetOptions(Flow, []).

% Caso recursivo, explora cada opci�n en busca de la keyword

flowIdsFilter([_, _, [Op1|RestoOps]], Msg, List) :-
    optionIdsFilter(Op1, Msg, List) ;
    flowIdsFilter([_, _, RestoOps], Msg, List).

/*
 Nombre: flowIdsFilterNum/3

 Dominio: Flow, Msg (String), List

 Descripci�n: Misma idea que la anterior, regla recursiva que lo que
 hace es explorar las opciones de un flujo en busca del id que
 coincida con el string num�rico que se le entreg�, cuando la encuentra,
 devuelve una lista con el id del chatbot y flujo asociados a la opcion

 Recursion Usada: De cola

 Metas primarias: flowIdsFilterNum/3

 Metas secundarias: optionIdsFilterNum/3, floGetOptions/2
*/

% Condici�n de parada, no hay m�s opciones en el flujo, devuelve una
% lista vac�a

flowIdsFilterNum(Flow, _, []) :-
    flowGetOptions(Flow, []).

% Caso recursivo, explora cada opci�n en busca del ID correcto

flowIdsFilterNum([_, _, [Op1|RestoOps]], Msg, List) :-
    optionIdsFilterNum(Op1, Msg, List) ;
    flowIdsFilterNum([_ , _, RestoOps], Msg, List).

/*
 Nombre: flowOptionSearch/2

 Dominio: Flow, List

 Descripci�n: Regla recursiva que lo que hace es extraer todos los
 nombres de las opciones contenidas en un flujo.

 Recursion Usada: Natural

 Metas primarias: flowOptionSearch/2

 Metas secundarias: flowGetOptions/2, isNull/1, append/3,
 optionGetName/2
*/

% Condicion de parada, no hay m�s opciones en el flujo, devuelve una
% lista vac�a

flowOptionSearch(Flow, []) :-
    flowGetOptions(Flow, Options),
    isNull(Options).

% Caso recursivo, hay opciones en la lista, se obtiene el nombre de cada
% una y se agregan a una lista

flowOptionSearch(Flow, List) :-
    flowGetOptions(Flow, [Option1|RestoOptions]),
    optionGetName(Option1, Name),
    flowOptionSearch([_, _, RestoOptions], Acc),
    append(Acc, ["\n", Name], List).


