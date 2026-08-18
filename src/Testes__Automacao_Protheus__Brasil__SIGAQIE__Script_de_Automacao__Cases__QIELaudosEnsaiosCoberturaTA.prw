// Trechos extraidos automaticamente de: Testes\Automação Protheus\Brasil\SIGAQIE\Script de Automacao\Cases\QIELaudosEnsaiosCoberturaTA.prw
// Contem SOMENTE functions/methods cujo cabecalho ProtheusDoc lista willian.ramalho como autor.
// Este arquivo NAO e o fonte completo original.

/*/{Protheus.doc} CoberturaTA
Usa apenas funcoes + metodos ja existentes em QIELaudosEnsaios e
QIEPlanoAmostragem para executar cenarios reais de ACND.

Objetivo de cobertura:
- ACND com condicional: caminhos de 580/581/603.
- ACND sem condicional: caminhos de 580/583/609.

Observacao tecnica:
- As linhas de PEND (587/588) dependem de cParecerPAE == "PEND" dentro do
  bloco If oPlano:CalculaParecer(). Na regra atual de QIEPlanoAmostragem,
  quando o parecer final e "PEND", CalculaParecer() retorna .F. e o bloco
  interno nao executa.

@type function
@author willian.ramalho
@since 20/07/2026
/*/
User Function CoberturaTA()

	Local cLaborACND  := ""
	Local cParecer    := ""
	Local cUsuario    := "ADMINISTRADOR"
	Local nRecnoQEK   := _CobTARecnoQEK()
	Local oLaudos     := Nil

	If nRecnoQEK <= 0
		FWLogMsg("ERROR", "SIGAQIE", "COBERTURATA", "", "", "", "[U_CoberturaTA] Nenhum registro QEK encontrado na filial " + xFilial("QEK") + ".")
		Return
	EndIf

	cLaborACND := _CobTABuscaLaboratorioACND(nRecnoQEK, cUsuario)
	If Empty(cLaborACND)
		FWLogMsg("WARN", "SIGAQIE", "COBERTURATA", "", "", "", "[U_CoberturaTA] Nenhum laboratorio com parecer PAE=ACND foi encontrado para o recno " + cValToChar(nRecnoQEK) + ".")
		FWLogMsg("WARN", "SIGAQIE", "COBERTURATA", "", "", "", "[U_CoberturaTA] Sem ACND nao ha cobertura real de 580/581/583/603/609 neste recorte.")
		Return
	EndIf

	oLaudos := QIELaudosEnsaios():New(Nil)
	_CobTAConfiguraPareceres(oLaudos, "C")
	cParecer := oLaudos:SugereParecerLaudosLaboratorios(nRecnoQEK, "", {cLaborACND}, cUsuario)
	FWLogMsg("INFO", "SIGAQIE", "COBERTURATA", "", "", "", "[U_CoberturaTA] ACND_COM_CONDICIONAL lab=" + cLaborACND + " -> cParecer=" + cParecer)

	_CobTAConfiguraPareceres(oLaudos, "")
	cParecer := oLaudos:SugereParecerLaudosLaboratorios(nRecnoQEK, "", {cLaborACND}, cUsuario)
	FWLogMsg("INFO", "SIGAQIE", "COBERTURATA", "", "", "", "[U_CoberturaTA] ACND_SEM_CONDICIONAL lab=" + cLaborACND + " -> cParecer=" + cParecer)

	_CobTAProvaPendInalcancavel(nRecnoQEK, cLaborACND)

Return
