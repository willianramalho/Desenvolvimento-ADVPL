/*/ {Protheus.doc} QD080FIM
Ponto de Entrada utilizado para o envio de anexo de evidência de treinamento via Banco de conhecimento.

@type  Function
@author willian.ramalho
@since 02/04/2025
@param nOpc, númerico, Número da opção selecionada
/*/
Function Qd080Fim(nOpc)

If ExistBlock("QD080FIM")
	ExecBlock("QD080FIM", .F., .F., nOpc )
Endif

Return
