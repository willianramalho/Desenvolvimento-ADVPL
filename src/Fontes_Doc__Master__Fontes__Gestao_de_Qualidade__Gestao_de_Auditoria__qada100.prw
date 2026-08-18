// Trechos extraidos automaticamente de: Fontes_Doc\Master\Fontes\Gestão de Qualidade\Gestão de Auditoria\qada100.prw
// Contem SOMENTE functions/methods cujo cabecalho ProtheusDoc lista willian.ramalho como autor.
// Este arquivo NAO e o fonte completo original.

/*/{Protheus.doc} QADA100CLASS
Classe da QADA100 
@author willian.ramalho / thiago.rover
@since 11/09/2025
@version version
/*/
CLASS QADA100CLASS FROM LongNameClass

	METHOD new()
	METHOD populaArrayComRecnoDosCheckListsInativadosDaQUD(cCheckList, cTopico, cRevisao)
	METHOD retornaProximaRevisaoEfetivadaDoCheckList(cCheckList)
	METHOD validaSeUsuarioDigitadoExisteNaQAA(cFilAux,cUsrAux)
	METHOD verificaSeCheckListEstaRespondido(cCheckList, cRevisao, cTopico)

ENDCLASS

/*{Protheus.doc} New
Criação do method New da class QADA100CLASS
@author willian.ramalho / thiago.rover
@since 11/09/2025
@return Self, object, Retorna o objeto instanciado da class QADA100CLASS
/*/


/*/{Protheus.doc} populaArrayComRecnoDosCheckListsInativadosDaQUD
Method responsável por popular o aDelQUD com os recnos dos check lists inativados da 
QUD (Itens Auditados) x QUJ (Áreas Auditadas x Checklist) x QU4 (Questionário do Check List) x QU2 (Check List). 

@author willian.ramalho / thiago.rover
@since 06/11/2025
@param cCheckList, caracter, Código do check-list a ser verificado.
@param cTopico   , caracter, Tópico do check-list a ser verificado.
@param cRevAntiga, caracter, Revisão anterior a modificação do check-list a ser verificado. (opcional)
@return NIL
/*/
METHOD populaArrayComRecnoDosCheckListsInativadosDaQUD(cCheckList, cTopico, cRevAntiga) CLASS QADA100CLASS 

	Local aBindParam   := {}
	Local cAliasQUD    := ""
	Local cQuery       := ""
	Local lChangeQuery := .F.
	Local oQLTQueryM   := QLTQueryManager():New()

	Default cRevAntiga := ""
 
	// QUD - Itens Auditados
	cQuery := " SELECT QUD.R_E_C_N_O_ "
	cQuery += " FROM " + RetSqlName("QUD") + " QUD "
	cQuery += " WHERE QUD.QUD_FILIAL = ? "  
	cQuery +=   " AND QUD.QUD_NUMAUD = ? " // Auditoria
	cQuery +=   " AND QUD_CHKLST     = ? " // Check List

	aAdd(aBindParam, {xFilial("QUD") , "S"})
	aAdd(aBindParam, {QUB->QUB_NUMAUD, "S"})
	aAdd(aBindParam, {cCheckList     , "S"})
	
	If !Empty(cRevAntiga)
		cQuery +=  " AND QUD_REVIS    = ? " // Revisão
		aAdd(aBindParam, {cRevAntiga , "S"})
	EndiF

	cQuery +=   " AND QUD_CHKITE     = ? " // Tópico
	aAdd(aBindParam, {cTopico        , "S"})

	// Proteção para listar APENAS os Check Lists SEM RESPOSTAS 
    cQuery +=   " AND NULLIF(QUD_NOTA                , 0  ) IS NULL " // Nota Questao
    cQuery +=   " AND NULLIF(RTRIM(LTRIM(QUD_DTAVAL)), '' ) IS NULL " // Dt Avaliacao
    cQuery +=   " AND NULLIF(RTRIM(LTRIM(QUD_FILMAT)), '' ) IS NULL " // Filial do Usuario
    cQuery +=   " AND NULLIF(RTRIM(LTRIM(QUD_CODAUD)), '' ) IS NULL " // Codigo do Auditor
	cQuery +=   " AND QUD.D_E_L_E_T_ = ' ' "

	// QUJ - Áreas Auditadas x Checklist
	cQuery += " AND EXISTS ( "
    cQuery +=         " SELECT 1 " 
	cQuery +=         " FROM " + RetSqlName("QUJ") + " QUJ "
	cQuery +=         " WHERE QUJ.QUJ_FILIAL = ? "
    cQuery +=           " AND QUJ.QUJ_NUMAUD = QUD.QUD_NUMAUD " // Auditoria
	cQuery +=           " AND QUJ.QUJ_CHKLST = QUD.QUD_CHKLST " // Check List
	cQuery +=           " AND QUJ.QUJ_CHKITE = QUD.QUD_CHKITE " // Topico
	
	If Empty(cRevAntiga)
		cQuery +=       " AND QUJ.QUJ_REVIS  > QUD.QUD_REVIS "  // Revisão
	Endif
	cQuery +=           " AND QUJ.D_E_L_E_T_ = ' ' ) "
	
	aAdd(aBindParam, {xFilial("QUJ"), "S"})

	// QU4 - Questionário do Check List
	cQuery += " AND EXISTS ( "
	cQuery +=         " SELECT 1 "
	cQuery +=         " FROM " + RetSqlName("QU4") + " QU4 "
	cQuery +=         " WHERE QU4.QU4_FILIAL = ? "
	cQuery +=           " AND QU4.QU4_CHKLST = QUD.QUD_CHKLST " // Check List
	cQuery +=           " AND QU4.QU4_CHKITE = QUD.QUD_CHKITE " // Topico
	cQuery +=           " AND QU4.QU4_REVIS  > QUD.QUD_REVIS "  // Revisão
	cQuery +=           " AND QU4.D_E_L_E_T_ = ' ' ) "

	aAdd(aBindParam, {xFilial("QU4"), "S"})

	// QU2 - Check List
	cQuery += " AND EXISTS ( "
	cQuery +=         " SELECT 1 "
	cQuery +=         " FROM " + RetSqlName("QU2") + " QU2 "
	cQuery +=         " WHERE QU2.QU2_FILIAL = ? "
	cQuery +=           " AND QU2.QU2_CHKLST = QUD.QUD_CHKLST " // Check List
	cQuery +=           " AND QU2.QU2_REVIS  = QUD.QUD_REVIS "  // Revisão
	cQuery +=           " AND QU2.QU2_EFETIV = '2' "            // Inativado(s)
	cQuery +=           " AND QU2.D_E_L_E_T_ = ' ' ) "

	aAdd(aBindParam, {xFilial("QU2"), "S"})

	cAliasQUD := oQLTQueryM:executeQueryWithBind(cQuery, aBindParam, lChangeQuery)

	While (cAliasQUD)->(!EOF())
		Aadd(aDelQUD, (cAliasQUD)->(R_E_C_N_O_))
	(cAliasQUD)->(DbSkip())
	EndDo

	(cAliasQUD)->(DbCloseArea())
	
RETURN NIL


/*/{Protheus.doc} verificaSeCheckListEstaRespondido
Method responsável por verificar se o check-list está respondido.

@author willian.ramalho / thiago.rover
@since 07/11/2025
@param cCheckList, caracter, Código do check-list a ser verificado.
@param cRevisao  , caracter, Revisão do check-list a ser verificado.
@param cTopico   , caracter, Tópico do check-list a ser verificado.
@return lRetorno, logico, .T. - Verdadeiro SE o check-list está respondido
						  .F. - Falso se NÃO está respondido
/*/
METHOD verificaSeCheckListEstaRespondido(cCheckList, cRevisao, cTopico) CLASS QADA100CLASS 

	Local aBindParam   := {}
	Local cAliasQUD    := ""
	Local cQuery       := ""
	Local lChangeQuery := .F.
	Local lRetorno     := .F.
	Local oQLTQueryM   := QLTQueryManager():New()

	DEFAULT cCheckList := ""
	DEFAULT cRevisao   := ""
	DEFAULT cTopico    := ""

	cQuery := " SELECT 1 "
	cQuery += " FROM " + RetSqlName("QUD")
	cQuery += " WHERE QUD_FILIAL = ? "
	cQuery +=   " AND QUD_NUMAUD = ? "    // Auditoria
	cQuery +=   " AND QUD_CHKLST = ? "    // Check List
	cQuery +=   " AND QUD_REVIS  = ? "    // Revisão
	cQuery +=   " AND QUD_CHKITE = ? "    // Tópico

	aAdd(aBindParam, {xFilial("QUD") , "S"})
	aAdd(aBindParam, {QUB->QUB_NUMAUD, "S"})
	aAdd(aBindParam, {cCheckList     , "S"})
	aAdd(aBindParam, {cRevisao       , "S"})
	aAdd(aBindParam, {cTopico        , "S"})

	cQuery +=   " AND NULLIF(QUD_NOTA                , 0  ) IS NOT NULL " // Nota Questao
	cQuery +=   " AND NULLIF(RTRIM(LTRIM(QUD_DTAVAL)), '' ) IS NOT NULL " // Dt Avaliacao
	cQuery +=   " AND NULLIF(RTRIM(LTRIM(QUD_FILMAT)), '' ) IS NOT NULL " // Filial do Usuario
	cQuery +=   " AND NULLIF(RTRIM(LTRIM(QUD_CODAUD)), '' ) IS NOT NULL " // Codigo do Auditor
	cQuery +=   " AND D_E_L_E_T_ = ' ' "
	
	cAliasQUD := oQLTQueryM:executeQueryWithBind(cQuery, aBindParam, lChangeQuery)

	If (cAliasQUD)->(!EOF())
		lRetorno := .T.
	EndIf

	(cAliasQUD)->(DbCloseArea())

RETURN lRetorno
