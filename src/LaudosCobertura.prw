/*/{Protheus.doc} LaudosCobertura
Funcao de cobertura de teste para o metodo SugereParecerLaudosLaboratorios
da classe QIELaudosEnsaios.

Cobre as linhas:
  585 - ElseIf cParecerPAE == "ACND"
  586 - If !Empty(self:cPrimeiroCondicional)
  588 - cConTmp := self:cPrimeiroCondicional
  592 - cPenTmp := "PEND"  (ramo Else do If !Empty)
  593 - ElseIf cParecerPAE == "APRV"
  607 - If !Empty(cConTmp)
  608 - cPriCondicional := cConTmp
  613 - If !Empty(cPenTmp)
  614 - cPriPendente := cPenTmp

CENARIOS:
  C1 - PAE retorna "ACND" + cPrimeiroCondicional preenchido  -> linhas 585,586,588,607,608
  C2 - PAE retorna "ACND" + cPrimeiroCondicional vazio       -> linhas 585,586,592,613,614
  C3 - PAE retorna "APRV"                                    -> linha  593
  C4 - PAE retorna "PEND"                                    -> linhas 613,614

COMO USAR:
  Compile e execute via SmartClient: U_LAUDOSCOBERTURA
  Nao requer recnos reais — usa dados mockados.

@type function
@author willian.ramalho
@since 21/07/2026
@return Nil
/*/
User Function LaudosCobertura()

    Local nRecno   := 1           as Numeric
    Local aLabs    := {"LAB001"}  as Array
    Local cUsuario := UsrRetName(RetCodUsr()) as Character
    Local cParecer := ""          as Character
    Local oLaudos  := Nil         as Object

    // =========================================================================
    // CENARIO 1: PAE retorna "ACND" + cPrimeiroCondicional preenchido
    // Cobre: 585, 586, 588, 607, 608
    // =========================================================================
    MsgAlert("[C1] PAE=ACND + cPrimeiroCondicional preenchido")

    oLaudos := QIELaudosEnsaiosMock():New("ACND")
    oLaudos:cPrimeiroCondicional := "COND01"

    cParecer := oLaudos:SugereParecerLaudosLaboratorios(nRecno, "", aLabs, cUsuario)

    MsgAlert("[C1] Concluido | Parecer=" + cParecer)
    oLaudos := Nil

    // =========================================================================
    // CENARIO 2: PAE retorna "ACND" + cPrimeiroCondicional vazio
    // Cobre: 585, 586 (ramo Else), 592, 613, 614
    // =========================================================================
    MsgAlert("[C2] PAE=ACND + cPrimeiroCondicional vazio")

    oLaudos := QIELaudosEnsaiosMock():New("ACND")
    // cPrimeiroCondicional permanece "" para acionar o ramo Else -> linha 592

    cParecer := oLaudos:SugereParecerLaudosLaboratorios(nRecno, "", aLabs, cUsuario)

    MsgAlert("[C2] Concluido | Parecer=" + cParecer)
    oLaudos := Nil

    // =========================================================================
    // CENARIO 3: PAE retorna "APRV"
    // Cobre: 593
    // =========================================================================
    MsgAlert("[C3] PAE=APRV")

    oLaudos := QIELaudosEnsaiosMock():New("APRV")
    oLaudos:cPrimeiroAprovado := "APRV01"

    cParecer := oLaudos:SugereParecerLaudosLaboratorios(nRecno, "", aLabs, cUsuario)

    MsgAlert("[C3] Concluido | Parecer=" + cParecer)
    oLaudos := Nil

    // =========================================================================
    // CENARIO 4: PAE retorna "PEND"
    // Cobre: 613, 614
    // =========================================================================
    MsgAlert("[C4] PAE=PEND")

    oLaudos := QIELaudosEnsaiosMock():New("PEND")

    cParecer := oLaudos:SugereParecerLaudosLaboratorios(nRecno, "", aLabs, cUsuario)

    MsgAlert("[C4] Concluido | Parecer=" + cParecer)
    oLaudos := Nil

Return
