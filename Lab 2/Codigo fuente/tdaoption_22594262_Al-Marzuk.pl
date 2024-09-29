/*
 Nombre: optionGetKeywords/2

 Dominio: Option, Keywords (List)

 Descripci�n: Entrega las Keywords del Option
 */
optionGetKeywords([_, _, _, _, Keywords], Keywords).

/*
 Nombre: optionGetChatbotID/2

 Dominio: Option, ChatbotID (Integer)

 Descripci�n:  Entrega la ID del chatbot asociado a la opci�n
 */

optionGetChatbotID([_, _, CbID, _, _], CbID).

/*
 Nombre: optionGetFlowID/2

 Dominio: Option, FlowID (Integer)

 Descripci�n: Entrega la ID del flow asociado a la opci�n
 */

optionGetFlowID([_, _, _, FlowID, _], FlowID).

/*
 Nombre: optionGetName/2

 Dominio: Option, Name (String)

 Descripci�n: Entrega el nombre asociado a la opci�n
 */

optionGetName([_, Name, _, _, _], Name).

/*
 Nombre: optionGetID/2

 Dominio: Option, ID (Integer)

 Descripci�n: Entrega el ID asociado a la opci�n
 */


optionGetID([ID, _, _, _, _], ID).

/*
 Nombre: optionIdsFilter/3

 Dominio: Option, Msg (String), List

 Descripci�n: busca entre las keywords de una opci�n, y entrega el id
 del Chatbot y el id del Flow asociados.

 Metas primarias: optionIdsFilter/3

 Metas secundarias: optionGetKeywords/2, optionGetFlowID/2,
 optionGetChatbotID/2, member/2
 */

optionIdsFilter(Option, Msg, List) :-
    optionGetKeywords(Option, Keywords),
    optionGetFlowID(Option, FlowID),
    optionGetChatbotID(Option, CbID),
    member(Msg, Keywords),
    List = [CbID, FlowID].

/*
 Nombre: optionIdsFilterNum/3

 Dominio: Option, Msg (String), List

 Descripci�n: Misma idea que la funci�n anterior, recibe un string
 num�rico, lo compara con el id de la opci�n y entrega el id del Chatbot
 y el id del Flow asociados.

 Metas primarias: optionIdsFilterNum/3

 Metas secundarias: optionGetID/2, number_codes/2, optionGetFlowID/2,
 optionGetChatbotID/2
 */


optionIdsFilterNum(Option, Msg, List) :-
    optionGetID(Option, ID),
    number_codes(Num, Msg),
    ID = Num,
    optionGetFlowID(Option, FID),
    optionGetChatbotID(Option, CbID),
    List = [CbID, FID].

/*
 nombre: isNull/1
 Descripci�n: Se declara un hecho, isNull retorna true si se le pasa una
 lista vac�a como argumento
 Dominio: Cualquier cosa
*/

isNull([]).

