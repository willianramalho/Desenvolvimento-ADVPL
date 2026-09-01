/*/{Protheus.doc} exibeAvisoSubstituicaoPorSmartx
Monta e exibe o dialogo modal de aviso de substituicao da QIEA040.
Dois botoes: "OK" (fecha sem suprimir) e "Lembrar mais tarde (7 dias)" (suprime).
@author willian.ramalho
@since 18/08/2026
@version P12
@return lLembrar, logico, .T. se o usuario clicou em "Lembrar mais tarde"
/*/
Method exibeAvisoSubstituicaoPorSmartx() Class QIEA040AuxClass

	Local aButtons   := {}
	Local lLembrar   := .F.   // .T. = clicou em "Lembrar mais tarde"
	Local oContainer := NIL
	Local oFont      := NIL   // objeto de fonte para o texto da mensagem
	Local oModal     := NIL

	// --- Cria a fonte: Arial, 14px, sem negrito ---
	// nAltura negativo = tamanho exato em pixels
	oFont := TFont():New('Arial', /*nLargura*/, -14, /*lBold*/ .F.)

	oModal := FWDialogModal():New()
	oModal:SetTitle(OemToAnsi(STR0010)) // STR0010 - "Atenção!"
	oModal:SetEscClose(.F.)             // Nao fecha com ESC (forcando escolha consciente)
	oModal:SetCloseButton(.F.)          // Remove o X do canto superior direito
	oModal:setSize(100, 300)            // Altura x Largura em pixels
	oModal:createDialog()

	// --- Botao "Lembrar mais tarde (7 dias)" ---
	// Fica a esquerda, e a acao menos urgente
	AAdd(aButtons, { ;
		"",                                                          ; // [1] Compatibilidade (descontinuado no P12)
		OemToAnsi(STR0011),                    						 ; // [2] Titulo do botao // STR0011 - "Lembrar mais tarde (7 dias)"
		{|| lLembrar := .T., oModal:DeActivate()},                   ; // [3] Bloco de codigo
		OemToAnsi(STR0012),      									 ; // [4] Tooltip (help do botao) // STR0012 - "Suprimir este aviso pelos próximos 7 dias"
		0,                                                           ; // [5] ShortCut
		.T.,                                                         ; // [6] Visivel na barra
		.F.                                                          ; // [7] Visivel na configuracao
	})

	oModal:AddButtons(aButtons)

	// --- Botao "OK" ---
	// Fica a direita (padrao), e o botao principal/focal
	oModal:addOkButton({|| lLembrar := .F., oModal:DeActivate()}, "OK")

	// --- Conteudo do dialogo ---
	oContainer := TPanel():New(,,, oModal:getPanelMain())
	oContainer:Align := CONTROL_ALIGN_ALLCLIENT

	TSay():New(15, 10, ;
		{|| OemToAnsi("A partir da versão 12.1.2710 esta rotina deve ser substituída pela nova QIEA040SX que já está disponível para uso a partir da versão 12.1.2610.")}, ;
		oContainer, /*cPicture*/, oFont, , , , .T., , , 285, 20, , , , , , .T.)

	oModal:Activate()

Return lLembrar
