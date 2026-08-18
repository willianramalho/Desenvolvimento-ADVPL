// Trechos extraidos automaticamente de: Fontes_Doc\Master\Fontes\Gestão de Qualidade\Gestão de PPAP\qppxfun.prw
// Contem SOMENTE functions/methods cujo cabecalho ProtheusDoc lista willian.ramalho como autor.
// Este arquivo NAO e o fonte completo original.

/*/{Protheus.doc} QPPVERAVISO
Verifica e exibe o aviso de descontinuacao do modulo PPAP.
A preferencia de supressao e persistida por usuario via FWProfile por contexto.
@type Function
@author willian.ramalho
@since 01/07/2026
@version P12
@param cContexto, caractere, "LOAD" para entrada do modulo ou "ROTINA" para entrada de rotina
/*/
Function QPPVERAVISO(cContexto)

	Local cDataGrava := ""
	Local cTask      := ""
	Local dDataExp   := CToD("")
	Local lExibir    := .F.
	Local oProfile   := FWProfile():New()

	Default cContexto := "ROTINA"

	cContexto := Upper(AllTrim(cContexto))
	If cContexto == "LOAD"
		cTask := QPPAP_TASK_LOAD
	Else
		cTask := QPPAP_TASK_ROT
	EndIf

	// Carrega o profile do usuario atual
	oProfile:SetUser(RetCodUsr())
	oProfile:SetProgram(QPPAP_PROG)
	oProfile:SetTask(cTask)
	oProfile:Load()

	cDataGrava := AllTrim(oProfile:GetStringProfile())

	If Empty(cDataGrava)
		// Nunca suprimiu: exibe o aviso
		lExibir := .T.
	Else
		// Verifica se o periodo de supressao ja expirou
		dDataExp := SToD(cDataGrava)
		lExibir  := (dDataBase >= dDataExp)
	EndIf

	If lExibir
		// Retorna .T. se o usuario clicou em "Lembrar mais tarde"
		If QPPMSGWARN()
			// Grava a data de expiracao: data base do servidor + 7 dias
			oProfile:SetStringProfile(DToS(dDataBase + QPPAP_DIAS))
			oProfile:Save()
		EndIf
	EndIf

	FreeObj(oProfile)
	oProfile := Nil

Return Nil


/*/{Protheus.doc} QPPMSGWARN
Monta e exibe o dialogo modal de aviso de descontinuação do modulo (47) - PPAP.
Dois botoes: "OK" (fecha sem suprimir) e "Lembrar mais tarde (7 dias)" (suprime).
@type Function
@author willian.ramalho
@since 30/06/2026
@version P12
@return lLembrar, logico, .T. se o usuario clicou em "Lembrar mais tarde"
/*/
Function QPPMSGWARN()

    Local aButtons   := {}
    Local cMensagem  := ""
	Local cPula1Lin  := Chr(13)+Chr(10)
	Local cPula2Lin  := Chr(13)+Chr(10)+Chr(13)+Chr(10)
    Local lLembrar   := .F. // .T. = clicou em "Lembrar mais tarde"
    Local oContainer := NIL
    Local oFont      := NIL // objeto de fonte para o texto da mensagem
    Local oModal     := NIL

    oFont := TFont():New('Arial', , -14, .F.)

    oModal:= FWDialogModal():New()
    oModal:SetTitle("Atenção")
    oModal:SetEscClose(.F.)      // Não fecha com ESC (forçando escolha consciente)
    oModal:SetCloseButton(.F.)   // Remove o X do canto superior direito
    oModal:SetFreeArea(340, 120) // Largura x Altura da área útil em pixels
    oModal:CreateDialog()

    // --- Botão "Lembrar mais tarde (7 dias)" ---
    // Fica à esquerda, é a ação menos urgente
    AAdd(aButtons, { ;
                     "",                                        ; // [1] Compatibilidade (descontinuado no P12)
                     OemToAnsi(STR0008),                        ; // [2] Titulo do botao STR0008 - "Lembrar mais tarde (7 dias)"
                     {|| lLembrar := .T., oModal:DeActivate()}, ; // [3] Bloco de codigo
                     OemToAnsi(STR0009),                        ; // [4] Tooltip STR0009 - "Suprimir este aviso pelos próximos 7 dias"
                     0,                                         ; // [5] ShortCut
                     .T.,                                       ; // [6] Visivel na barra
                     .F.                                        ; // [7] Visivel na configuracao
	})

    oModal:AddButtons(aButtons)

    // Botão "OK"
    // Fica à direita (padrão), é o botão principal/focal
    oModal:addOkButton({|| lLembrar := .F., oModal:DeActivate()}, "OK")

    // Conteúdo da diálogo
    oContainer := TPanel():New(01, 01,, oModal:getPanelMain())
    oContainer:Align := CONTROL_ALIGN_ALLCLIENT

    /*
	STR0010 - "Informamos que as rotinas do módulo 47-SIGAPPAP - Processo de Aprovação de Peças de Produção"
	STR0011 - "serão descontinuadas de forma definitiva."
	STR0012 - "A TOTVS garantirá a manutenção até 31/12/2026 e o suporte técnico do módulo até o dia 30/06/2027."
	STR0013 - "Na release 12.1.2710 este módulo não estará no menu padrão do Protheus."
	STR0014 - "Por favor, entre em contato com seu departamento de TI para que as avaliações necessárias sejam realizadas."
	STR0015 - "Em caso de dúvidas, podem acessar o Atendimento TOTVS."
	*/
	cMensagem := STR0010 + cPula1Lin + STR0011 + cPula2Lin + STR0012 + cPula2Lin + STR0013 + cPula2Lin +;
	     	     STR0014 + cPula2Lin + STR0015

    // Parâmetros TSay: nLin, nCol, bValor, oWnd, cPicture, oFont, nAlinhamento, nClrText, nClrBack, lMultiLine, lPixel, lTransp, nWidth, nHeight
	TSay():New(10, 10, {|| cMensagem}, oContainer, /*cPicture*/, oFont, /*nAlinhamento*/, /*nClrText*/, /*nClrBack*/, .T., /*lPixel*/, /*lTransp*/, 340, 120)                    
    oModal:Activate()

Return lLembrar
