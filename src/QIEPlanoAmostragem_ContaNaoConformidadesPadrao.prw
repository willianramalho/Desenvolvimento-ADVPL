/*/{Protheus.doc} ContaNaoConformidadesPadrao
Conta não-conformidades de forma padrão (sem plano específico).
Utiliza classificação por classe de NC.
@type method
@author brunno.costa / willian.ramalho
@since 29/04/2026
@version 1.0
@param oEnsaio, object, Dados do ensaio
@return aContador, array, [NCCríticas, NCGraves, NCToleráveis]
/*/
METHOD ContaNaoConformidadesPadrao(oEnsaio) CLASS QIEPlanoAmostragem

    Local aContador := {0, 0, 0}
    Local aMedicoes := oEnsaio["Medicoes"]
    Local cClasse   := ""
    Local nIdx      := 0
    Local oMedicao  := Nil

    For nIdx := 1 To Len(aMedicoes)
        oMedicao := aMedicoes[nIdx]

        If oMedicao["ResultadoMedicao"] == "R" .And. !oMedicao["RegistroExcluido"]
            cClasse := Upper(AllTrim(oMedicao["ClasseNC"]))

            Do Case
                Case cClasse == "C"
                    aContador[NC_CRITICAS]++
                Case cClasse == "G"
                    aContador[NC_GRAVES]++
                OtherWise
                    aContador[NC_TOLERAVEIS]++
            EndCase
        EndIf
    Next nIdx

Return aContador
