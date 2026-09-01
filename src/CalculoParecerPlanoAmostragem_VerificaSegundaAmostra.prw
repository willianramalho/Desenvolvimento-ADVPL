/*/{Protheus.doc} VerificaExistenciaSegundaAmostra
Verifica existência de segunda amostra baseada em presença de medicão.
@type method
@author brunno.costa / willian.ramalho
@since 22/05/2026
@version 1.0
@param oResultado, object, Resultado do ensaio
@return lExiste, lógical, .T. se encontrou medição com número amostra 2
/*/
METHOD VerificaExistenciaSegundaAmostra(oResultado) CLASS QIEPlanoAmostragem

    Local aMedicoes := oResultado["Medicoes"]
    Local lExiste   := .F.
    Local nIdx      := 0
    Local oMedicao      := Nil

    For nIdx := 1 To Len(aMedicoes)

        oMedicao := aMedicoes[nIdx]

        If !oMedicao["RegistroExcluido"] .And. oMedicao["NumeroAmostra"] == 2
            lExiste := .T.
            Exit
        EndIf

    Next nIdx

Return lExiste
