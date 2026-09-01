/*/{Protheus.doc} BuscaDadosPlanoAmostragemComHistorico
Busca dados do plano de amostragem com suporte a histórico.
@type method
@author brunno.costa / willian.ramalho
@since 22/05/2026
@version 1.0
@param cCodEnsaio, character, Código do ensaio
@return aDadosPlno, array, Array com dados do plano
/*/
METHOD BuscaDadosPlanoAmostragemComHistorico(cCodEnsaio) CLASS QIEPlanoAmostragem

    Local aAreaAnt   := GetArea()
    Local aDadosPlno := {0, 0, 0, 0, 0, 0}
    Local aRetQep    := {}
    Local cCampoPref := ""
    Local cChave     := ""
    Local cTabEspec  := ""
    Local lEnconHist := .F.

    DbSelectArea("QEK")
    QEK->(DbGoTo(self:nRecnoQEK))

    If !QEK->(Eof())
        
        // Define tabela de especificação
        cTabEspec  := If(QEK->QEK_TIPONF $ "B/D", "QF6", "QF4")
        cCampoPref := If(QEK->QEK_TIPONF $ "B/D", "QF6_", "QF4_")

        DbSelectArea("QF5")
        QF5->(DbSetOrder(3)) // Índice QF5_FILIAL+QF5_FORNEC+QF5_LOJFOR+QF5_PRODUT+QF5_REVI+QF5_ENSAIO

        cChave := xFilial("QF5") + QEK->QEK_FORNEC + QEK->QEK_LOJFOR + QEK->QEK_PRODUT + QEK->QEK_REVI + cCodEnsaio

        If QF5->(MsSeek(cChave))

            // Encontrou no histórico
            aDadosPlno[1] := QF5->QF5_TAMA1
            aDadosPlno[2] := QF5->QF5_ACEI1
            aDadosPlno[3] := QF5->QF5_REJEI1
            aDadosPlno[4] := QF5->QF5_TAMA2
            aDadosPlno[5] := QF5->QF5_ACEI2
            aDadosPlno[6] := QF5->QF5_REJEI2

            If aDadosPlno[1] > 0 .Or. aDadosPlno[2] > 0 .Or. aDadosPlno[3] > 0 .Or. ;
               aDadosPlno[4] > 0 .Or. aDadosPlno[5] > 0 .Or. aDadosPlno[6] > 0
                lEnconHist := .T.
            EndIf
        EndIf

        // Se não encontrou em histórico, busca em QF4/QF6 (padrão)
        If !lEnconHist
            DbSelectArea(cTabEspec)
            (cTabEspec)->(DbSetOrder(1))

            If (cTabEspec)->(MsSeek(xFilial(cTabEspec) + QEK->QEK_FORNEC + QEK->QEK_LOJFOR + QEK->QEK_PRODUT + QEK->QEK_REVI + cCodEnsaio))

                aRetQep := Qep_RetAmostra(;
                    (cTabEspec)->&(cCampoPref + "TIPAMO"),;
                    (cTabEspec)->&(cCampoPref + "PLAMO"),;
                    (cTabEspec)->&(cCampoPref + "NIVEL"),;
                    (cTabEspec)->&(cCampoPref + "NQA"),;
                    QEK->QEK_TAMAMO,;
                    "QEK_TAMAMO",;
                    .F.;
                )

                aDadosPlno := self:MontaDadosPlanoAmostragem(aRetQep, cTabEspec, cCampoPref)

            EndIf
        EndIf
    EndIf


    RestArea(aAreaAnt)

Return aDadosPlno
