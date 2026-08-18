/*/{Protheus.doc} ValidaPreCondicoesTamanhoAmostra
Valida pré-condições de tamanho de amostra comparando quantidade de medições.
@type method
@author brunno.costa / willian.ramalho
@since 22/05/2026
@version 1.0
@param oEnsaio, object, Dados do ensaio
@return lValido, lógical, .F. se divergência encontrada e não deve prosseguir
/*/
METHOD ValidaPreCondicoesTamanhoAmostra(oEnsaio) CLASS QIEPlanoAmostragem

    Local aDadosPlno := {0, 0, 0, 0, 0, 0}
    Local aMedicoes  := {}
    Local cCodEnsaio := ""
    Local lValido    := .T.
    Local nIdx       := 0
    Local nTamAmos1  := 0
    Local nTamAmos2  := 0
    Local nTotMed1   := 0
    Local nTotMed2   := 0
    Local oMedicao   := Nil

    If ValType(oEnsaio["Medicoes"]) == "A"
        aMedicoes := oEnsaio["Medicoes"]
    EndIf

    If ValType(oEnsaio["DadosPlano"]) == "A" .And. Len(oEnsaio["DadosPlano"]) >= 6
        aDadosPlno := oEnsaio["DadosPlano"]
    Else
        cCodEnsaio := AllTrim(cValToChar(Iif(oEnsaio["CodigoEnsaio"] == Nil, "", oEnsaio["CodigoEnsaio"])))
        If !Empty(cCodEnsaio)
            aDadosPlno := self:BuscaDadosPlanoAmostragemComHistorico(cCodEnsaio)
            oEnsaio["DadosPlano"] := aDadosPlno
        EndIf
    EndIf

    nTamAmos1 := aDadosPlno[1]
    nTamAmos2 := aDadosPlno[4]

    // Separa medições por número de amostra
    For nIdx := 1 To Len(aMedicoes)
        oMedicao := aMedicoes[nIdx]

        If !oMedicao["RegistroExcluido"]
            If oMedicao["NumeroAmostra"] == 1
                nTotMed1++
            ElseIf oMedicao["NumeroAmostra"] == 2
                nTotMed2++
            EndIf
        EndIf
    Next nIdx

    // Valida tamanho amostra 1
    If nTotMed1 <> nTamAmos1 .And. nTamAmos1 > 0
        // STR0027 - "Divergência de tamanho de amostra 1: esperado "
        // STR0029 - ", encontrado "
        self:cMensagem := STR0027 + AllTrim(Str(nTamAmos1)) + STR0029 + AllTrim(Str(nTotMed1))
        lValido := .F.
    EndIf

    // Valida tamanho amostra 2 (se houver)
    If lValido .And. nTamAmos2 > 0 .And. nTotMed2 > 0
        If nTotMed2 <> nTamAmos2
            // STR0028 - "Divergência de tamanho de amostra 2: esperado "
            // STR0029 - ", encontrado "
            self:cMensagem := STR0028 + AllTrim(Str(nTamAmos2)) + STR0029 + AllTrim(Str(nTotMed2))
            lValido := .F.
        EndIf
    EndIf

Return lValido
