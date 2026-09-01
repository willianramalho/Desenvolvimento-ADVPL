/*/{Protheus.doc} AplicaRegrasPlanoAmostragem
Aplica regras de aceite/rejeite baseado nos planos de amostragem.
@type method
@author brunno.costa / willian.ramalho
@since 29/04/2026
@version 1.0
@return lSucesso, lógical, .T. se definiu parecer
/*/
METHOD AplicaRegrasPlanoAmostragem() CLASS QIEPlanoAmostragem

    Local cParcLocal := ""
    Local lAprovado  := .F.
    Local lCondicnl  := .F.
    Local lReprovado := .F.
    Local nIdx       := 0
    Local oResultado := Nil

    For nIdx := 1 To Len(self:aResultado)
        oResultado := self:aResultado[nIdx]

        // Verifica se é amostragem dupla (tipo começa com "D" ou é "3")
        If SubStr(oResultado["TipoPlano"], 1, 1) $ "D/3"
            cParcLocal := self:AvaliaAmostragemDupla(oResultado)
        Else
            cParcLocal := self:AvaliaAmostragemSimples(oResultado)
        EndIf

        // Atualiza flags de status
        If cParcLocal == "REPR"
            lReprovado := .T.
            Exit // Reprovação interrompe análise
        ElseIf cParcLocal == "ACND"
            lCondicnl := .T.
        ElseIf cParcLocal == "APRV"
            lAprovado := .T.
        EndIf
    Next nIdx

    // Define parecer final baseado nas flags
    If lReprovado
        self:cParecer := "REPR"
    ElseIf lCondicnl
        self:cParecer := "ACND"
    ElseIf lAprovado
        self:cParecer := "APRV"
    Else
        self:cParecer := "PEND"
    EndIf

Return self:cParecer <> "PEND"
