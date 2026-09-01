/*/{Protheus.doc} ContaNaoConformidadesNBR5429
Conta não-conformidades para plano NBR5429 (Índice de Defeitos).
@type method
@author brunno.costa / willian.ramalho
@since 29/04/2026
@version 1.0
@param oEnsaio, object, Objeto JSON com dados do ensaio
@return aContador, array, [ÍndiceDefeitos, 0, 0]
/*/
METHOD ContaNaoConformidadesNBR5429(oEnsaio, nLIE, nLSE) CLASS QIEPlanoAmostragem

    Local aAreaAnt   := GetArea()
    Local aContador  := {0, 0, 0}
    Local aMed5429   := {}
    Local aMedicoes  := oEnsaio["Medicoes"]
    Local aResCalc   := {}
    Local nIdxMed    := 0
    Local nIndDefeit := 0
    Local oMedicao   := Nil

    Default nLIE       := 0
    Default nLSE       := 0

    // Prepara vetor simples de medições para QA_Def5429/QA_CalcDV
    For nIdxMed := 1 To Len(aMedicoes)
        oMedicao := aMedicoes[nIdxMed]

        If !oMedicao["RegistroExcluido"]
            If ValType(oMedicao["ValorMedido"]) $ "CN"
                AAdd(aMed5429, oMedicao["ValorMedido"])
            EndIf
        EndIf
        
    Next nIdxMed

    // Calcula índice de defeitos NBR5429
    If Len(aMed5429) > 0
        aResCalc   := self:CalculaIndiceDefeitosNBR5429(aMed5429, oEnsaio, nLIE, nLSE)
        nIndDefeit := aResCalc[5] // Posição 5 contém o índice
    EndIf

    // Armazena índice como NC crítica para avaliação
    aContador[NC_CRITICAS] := nIndDefeit

    RestArea(aAreaAnt)

Return aContador
