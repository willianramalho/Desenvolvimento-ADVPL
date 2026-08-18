/*/{Protheus.doc} ContaNaoConformidadesQS9000
Conta não-conformidades para plano QS9000.
Utiliza contagem simples sem classificação.
@type method
@author brunno.costa / willian.ramalho
@since 29/04/2026
@version 1.0
@param oEnsaio, object, Dados do ensaio
@return aContador, array, [TotalNCs, 0, 0]
/*/
METHOD ContaNaoConformidadesQS9000(oEnsaio) CLASS QIEPlanoAmostragem

    Local aContador := {0, 0, 0}
    Local aMedicoes := oEnsaio["Medicoes"]
    Local nIdx      := 0
    Local oMedicao  := Nil

    For nIdx := 1 To Len(aMedicoes)
        oMedicao := aMedicoes[nIdx]

        If oMedicao["ResultadoMedicao"] == "R" .And. !oMedicao["RegistroExcluido"]
            aContador[NC_CRITICAS]++ // Todas como críticas
        EndIf
    Next nIdx

Return aContador
