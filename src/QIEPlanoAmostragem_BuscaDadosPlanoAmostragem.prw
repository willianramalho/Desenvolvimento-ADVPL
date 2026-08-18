/*/{Protheus.doc} BuscaDadosPlanoAmostragem
Busca dados completos do plano de amostragem (aceite, rejeite, tamanhos de amostra).
@type method
@author brunno.costa / willian.ramalho
@since 29/04/2026
@version 1.0
@param cCodEnsaio, character, Código do ensaio
@return aDadosPlno, array, Array com 6 posições:
    [1] Tamanho Amostra 1
    [2] Aceite 1
    [3] Rejeite 1
    [4] Tamanho Amostra 2 (amostragem dupla)
    [5] Aceite 2 (amostragem dupla)
    [6] Rejeite 2 (amostragem dupla)
/*/
METHOD BuscaDadosPlanoAmostragem(cCodEnsaio) CLASS QIEPlanoAmostragem

    Local aAreaAnt   := GetArea()
    Local aDadosPlno := {0, 0, 0, 0, 0, 0}
    Local aRetQep    := {}
    Local cCampoPref := ""
    Local cTabEspec  := ""

    DbSelectArea("QEK")
    QEK->(DbGoTo(self:nRecnoQEK))

    If !QEK->(Eof())
        // Define tabela e prefixo
        cTabEspec  := If(QEK->QEK_TIPONF $ "B/D", "QF6", "QF4")
        cCampoPref := If(QEK->QEK_TIPONF $ "B/D", "QF6_", "QF4_")

        DbSelectArea(cTabEspec)
        // Índice 1 de ambas as tabelas tem a mesma estrutura posicional:
        //   QF4: QF4_FILIAL+QF4_FORNEC+QF4_LOJFOR+QF4_PRODUT+QF4_REVI+QF4_ENSAIO
        //   QF6: QF6_FILIAL+QF6_CLIENT+QF6_LOJCLI+QF6_PRODUT+QF6_REVI+QF6_ENSAIO
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

    RestArea(aAreaAnt)

Return aDadosPlno
