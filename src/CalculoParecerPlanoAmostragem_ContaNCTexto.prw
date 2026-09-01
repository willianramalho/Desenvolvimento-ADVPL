/*/{Protheus.doc} ContaNaoConformidadesTexto
Conta não-conformidades para plano tipo Texto.
Utiliza contagem simples.
@type method
@author brunno.costa / willian.ramalho
@since 29/04/2026
@version 1.0
@param oEnsaio, object, Dados do ensaio
@return aContador, array, [TotalNCs, 0, 0]
/*/
METHOD ContaNaoConformidadesTexto(oEnsaio) CLASS QIEPlanoAmostragem

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
