/*/{Protheus.doc} CarregaMedicoesDoEnsaio
Carrega todas as medições de um ensaio específico da tabela QES.
@type method
@author brunno.costa / willian.ramalho
@since 29/04/2026
@version 1.0
@param nRecnoQER, numeric, Recno do ensaio na tabela QER
@return aMedicoes, array, Array de objetos JSON com dados das medições
/*/
METHOD CarregaMedicoesDoEnsaio(nRecnoQER) CLASS QIEPlanoAmostragem

    Local aAreaAnt  := GetArea()
    Local aMedicoes := {}
    Local cMinMax   := ""
    Local cResMed   := ""
    Local nLIE      := 0
    Local nLSE      := 0
    Local nValor    := 0
    Local oMedicao  := Nil

    DbSelectArea("QER")
    QER->(DbGoTo(nRecnoQER))

    If !QER->(Eof())

        DbSelectArea("QEK")
        QEK->(DbGoTo(self:nRecnoQEK))

        DbSelectArea("QE7")
        QE7->(DbSetOrder(1)) // QE7_FILIAL+QE7_PRODUT+QE7_REVI+QE7_ENSAIO
        If QE7->(DbSeek(xFilial("QE7") + QEK->QEK_PRODUT + QEK->QEK_REVI + QER->QER_ENSAIO))
            nLIE    := SuperVal(QE7->QE7_LIE)
            nLSE    := SuperVal(QE7->QE7_LSE)
            cMinMax := AllTrim(QE7->QE7_MINMAX)
        EndIf

        DbSelectArea("QES")
        QES->(DbSetOrder(1)) // QES_FILIAL+QES_CODMED

        If QES->(DbSeek(xFilial("QES") + QER->QER_CHAVE))

            While !QES->(Eof()) .And. ;
                  QES->QES_FILIAL == xFilial("QES") .And. ;
                  QES->QES_CODMED == QER->QER_CHAVE

                cResMed := Upper(AllTrim(QER->QER_RESULT))
                nValor  := SuperVal(QES->QES_MEDICA)

                oMedicao := JsonObject():New()
                oMedicao["ResultadoMedicao"] := cResMed
                oMedicao["ValorMedido"     ] := nValor
                oMedicao["ClasseNC"        ] := ""        // sem origem na QES
                oMedicao["NumeroAmostra"   ] := 1         // sem origem na QES (amostragem dupla indisponivel)
                oMedicao["DataEmissao"     ] := Date()    // nao persistido na QES
                oMedicao["HoraEmissao"     ] := Time()    // nao persistido na QES
                oMedicao["RegistroExcluido"] := QES->(Deleted())

                AAdd(aMedicoes, oMedicao)

                QES->(DbSkip())
            EndDo
        EndIf
    EndIf

    RestArea(aAreaAnt)

Return aMedicoes
