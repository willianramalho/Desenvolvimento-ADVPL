/*/{Protheus.doc} VerificaMedicaoAprovada
Verifica se há pelo menos uma medição aprovada no ensaio.
@type method
@author brunno.costa / willian.ramalho
@since 22/05/2026
@version 1.0
@param oResultado, object, Resultado do ensaio
@return lTemAprvd, lógical, .T. se encontrou medição aprovada
/*/
METHOD VerificaMedicaoAprovada(oResultado) CLASS QIEPlanoAmostragem

    Local aMedicoes := oResultado["Medicoes"]
    Local lTemAprvd := .F.
    Local nIdx      := 0
    Local oMedicao  := Nil

    For nIdx := 1 To Len(aMedicoes)

        oMedicao := aMedicoes[nIdx]

        If oMedicao["ResultadoMedicao"] == "A" .And. !oMedicao["RegistroExcluido"]
            lTemAprvd := .T.
            Exit
        EndIf

    Next nIdx

Return lTemAprvd
