/*/{Protheus.doc} CarregaEnsaiosComPlanoAmostragem
Carrega ensaios da inspeção com todos os dados de plano de amostragem.
Executa query otimizada com joins para obter dados de QER, QF4/QF6 e medições.
@type method
@author brunno.costa / willian.ramalho
@since 29/04/2026
@version 1.0
@return lSucesso, lógical, .T. se carregou ao menos um ensaio, .F. caso contrário
/*/
METHOD CarregaEnsaiosComPlanoAmostragem() CLASS QIEPlanoAmostragem

    Local aAreaAnt   := GetArea()
    Local aBindParam := {}
    Local cAliasQry  := ""
    Local cCampoEnt  := "" // Campo entidade: FORNEC (QF4) ou CLIENT (QF6)
    Local cCampoLoj  := "" // Campo loja:     LOJFOR (QF4) ou LOJCLI (QF6)
    Local cCampoPref := ""
    Local cQuery     := ""
    Local cTabEspec  := ""
    Local oEnsaio    := Nil

    // Posiciona na inspeção
    DbSelectArea("QEK")
    QEK->(DbGoTo(self:nRecnoQEK))

    If !QEK->(Eof())
        // Define tabela de específicação baseada no tipo de nota fiscal
        cTabEspec  := If(QEK->QEK_TIPONF $ "B/D", "QF6", "QF4")
        cCampoPref := If(QEK->QEK_TIPONF $ "B/D", "QF6_", "QF4_")
        cCampoEnt  := If(QEK->QEK_TIPONF $ "B/D", "CLIENT", "FORNEC")
        cCampoLoj  := If(QEK->QEK_TIPONF $ "B/D", "LOJCLI", "LOJFOR")

        // Monta query com bind variables (proteção contra SQL Injection)
        cQuery := " SELECT "
        cQuery +=   " QER.R_E_C_N_O_ AS RECNO_QER, "
        cQuery +=   " QER.QER_ENSAIO, "
        cQuery +=   " QER.QER_LABOR, "
        cQuery +=   " QER.QER_RESULT, "
        cQuery +=   " " + cTabEspec + "." + cCampoPref + "TIPAMO AS TIPO_AMOSTRAGEM, "
        cQuery +=   " " + cTabEspec + "." + cCampoPref + "PLAMO AS PLANO_AMOSTRAGEM, "
        cQuery +=   " " + cTabEspec + "." + cCampoPref + "NIVEL AS NIVEL_AMOSTRAGEM, "
        cQuery +=   " " + cTabEspec + "." + cCampoPref + "NQA AS NQA "
        cQuery += " FROM " + RetSqlName("QER") + " QER "

        // Join com específicação do produto
        cQuery += " INNER JOIN " + RetSqlName(cTabEspec) + " " + cTabEspec
        cQuery +=   " ON " + cTabEspec + "." + cCampoPref + "FILIAL = ? "
        cQuery +=  " AND " + cTabEspec + "." + cCampoPref + cCampoEnt + " = ? "
        cQuery +=  " AND " + cTabEspec + "." + cCampoPref + cCampoLoj + " = ? "
        cQuery +=  " AND " + cTabEspec + "." + cCampoPref + "PRODUT = ? "
        cQuery +=  " AND " + cTabEspec + "." + cCampoPref + "REVI = ? "
        cQuery +=  " AND " + cTabEspec + "." + cCampoPref + "ENSAIO = QER.QER_ENSAIO "
        cQuery +=  " AND " + cTabEspec + ".D_E_L_E_T_ = ' ' "

        // Filtros principais
        cQuery += " WHERE QER.QER_FILIAL = ? "
        cQuery +=   " AND QER.QER_NUMSEQ = ? "
        cQuery +=   " AND QER.D_E_L_E_T_ = ' ' "

        AAdd(aBindParam, {xFilial(cTabEspec), "S"})    // FILIAL tabela espec.
        AAdd(aBindParam, {QEK->QEK_FORNEC      , "S"}) // FORNEC
        AAdd(aBindParam, {QEK->QEK_LOJFOR      , "S"}) // LOJFOR
        AAdd(aBindParam, {QEK->QEK_PRODUT      , "S"}) // PRODUT
        AAdd(aBindParam, {QEK->QEK_REVI        , "S"}) // REVI
        AAdd(aBindParam, {xFilial("QER")       , "S"}) // FILIAL QER
        AAdd(aBindParam, {QEK->QEK_NUMSEQ      , "S"}) // NUMSEQ

        // Filtro de laboratório (se informado)
        If !Empty(self:cLaborat)
            cQuery += " AND QER.QER_LABOR = ? "
            AAdd(aBindParam, {self:cLaborat, "S"}) // LABOR
        EndIf

        cQuery    += " ORDER BY QER.QER_LABOR, QER.QER_ENSAIO "
        cQuery    := ChangeQuery(cQuery)
        cAliasQry := QLTQueryManager():executeQueryWithBind(cQuery, aBindParam)

        // Processa resultado da query
        While !(cAliasQry)->(Eof())

            oEnsaio := JsonObject():New()

            // Dados básicos do ensaio
            oEnsaio["RecnoQER"       ] := (cAliasQry)->RECNO_QER
            oEnsaio["CodigoEnsaio"   ] := AllTrim((cAliasQry)->QER_ENSAIO)
            oEnsaio["Laboratorio"    ] := AllTrim((cAliasQry)->QER_LABOR)
            oEnsaio["ResultadoEnsaio"] := AllTrim((cAliasQry)->QER_RESULT)

            // Dados do plano de amostragem
            oEnsaio["TipoAmostragem" ] := AllTrim((cAliasQry)->TIPO_AMOSTRAGEM)
            oEnsaio["PlanoAmostragem"] := AllTrim((cAliasQry)->PLANO_AMOSTRAGEM)
            oEnsaio["NivelAmostragem"] := AllTrim((cAliasQry)->NIVEL_AMOSTRAGEM)
            oEnsaio["NQA"            ] := AllTrim((cAliasQry)->NQA)

            // Carrega medições do ensaio
            oEnsaio["Medicoes"       ] := self:CarregaMedicoesDoEnsaio((cAliasQry)->RECNO_QER)

            // Busca dados completos do plano (aceite, rejeite, tamanhos)
            oEnsaio["DadosPlano"     ] := self:BuscaDadosPlanoAmostragemComHistorico(oEnsaio["CodigoEnsaio"])

            AAdd(self:aEnsaios, oEnsaio)

            (cAliasQry)->(DbSkip())
        EndDo

        (cAliasQry)->(DbCloseArea())
    EndIf

    RestArea(aAreaAnt)

Return (Len(self:aEnsaios) > 0)
