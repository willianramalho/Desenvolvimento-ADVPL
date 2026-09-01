/*/{Protheus.doc} VerificaMedicaoReprovada
Verifica se há pelo menos uma medição reprovada no ensaio.
@type method
@author brunno.costa / willian.ramalho
@since 29/04/2026
@version 1.0
@param oResultado, object, Resultado do ensaio
@return lTemReprv, lógical, .T. se encontrou medição reprovada
/*/
METHOD VerificaMedicaoReprovada(oResultado) CLASS QIEPlanoAmostragem

    Local aMedicoes := oResultado["Medicoes"]
    Local lTemReprv := .F.
    Local nIdx      := 0
    Local oMedicao  := Nil

    For nIdx := 1 To Len(aMedicoes)

        oMedicao := aMedicoes[nIdx]

        If oMedicao["ResultadoMedicao"] == "R" .And. !oMedicao["RegistroExcluido"]
            lTemReprv := .T.
            Exit
        EndIf

    Next nIdx

Return lTemReprv
