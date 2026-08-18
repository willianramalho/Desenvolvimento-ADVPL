/*/{Protheus.doc} FieldsUser
Percorre a aHeader e, para cada campo customizado que o cliente possui na QEH, alimenta a linha nCnt do aCols
com o valor vindo de QEH (quando o registro já existe) ou com o valor
padrão do campo via CriaVar() (quando é um novo registro).

PREACONDICOES:
- Se lFoundQEH == .T., o banco de dados QEH DEVE estar posicionado no registro correto.
- As variáveis aHeader e aCols são herdadas do escopo pai como Private.

@author willian.ramalho
@since 23/07/2026
@type Static Function
@param nCnt, 	Numerico, Linha corrente do aCols a ser preenchida
@param lFoundQEH, Logico, Indica se o registro ja existe em QEH (.T.) ou se e novo (.F.)
/*/
Static Function FieldsUser(nCnt,lFoundQEH)

	Local cCampo     := ""
	Local nFieldUser := 0

	For nFieldUser := 1 To Len(aHeader)
		// Percorre a aHeader e verifica se o campo e de usuario e nao e Virtual, se sim, alimenta o aCols com o valor do campo
		If GetSx3Cache(aHeader[nFieldUser,2], "X3_PROPRI") == "U" .AND.;
			GetSx3Cache(aHeader[nFieldUser,2], "X3_CONTEXT") <> "V"
			cCampo := AllTrim(aHeader[nFieldUser,2])
			If lFoundQEH
				// Pré-condição: QEH deve estar posicionado no registro correto
				aCols[nCnt][nFieldUser] := QEH->(&(cCampo))
			Else
				aCols[nCnt][nFieldUser] := CriaVar(cCampo)
			EndIf
		EndIf
	Next nFieldUser

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A090GrvST ³ Autor ³ Vera Lucia S. Simoes  ³ Data ³ 08/06/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava os Skip-Testes Individuais                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIEA090                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
