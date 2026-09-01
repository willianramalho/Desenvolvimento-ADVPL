/*/{Protheus.doc} SeparaNaoConformidadesPorAmostra
Separa contagem de NCs por número de amostra (para amostragem dupla).
@type method
@author brunno.costa / willian.ramalho
@since 29/04/2026
@version 1.0
@param oResultado, object, Resultado do ensaio
@return aNCPorAmos, array, [NC Amostra 1, NC Amostra 2]
/*/
METHOD SeparaNaoConformidadesPorAmostra(oResultado) CLASS QIEPlanoAmostragem

    Local aMedicoes  := oResultado["Medicoes"]
    Local aNCPorAmos := {0, 0}
    Local nIdx       := 0
    Local oMedicao       := Nil

    For nIdx := 1 To Len(aMedicoes)

        oMedicao := aMedicoes[nIdx]

        If oMedicao["ResultadoMedicao"] == "R" .And. !oMedicao["RegistroExcluido"]

            If oMedicao["NumeroAmostra"] == 1
                aNCPorAmos[1]++
            ElseIf oMedicao["NumeroAmostra"] == 2
                aNCPorAmos[2]++
            EndIf

        EndIf
    Next nIdx

Return aNCPorAmos
