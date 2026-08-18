// Trechos extraidos automaticamente de: Fontes_Doc\Master\Fontes\Gestão de Qualidade\Gestão de Não Conformidades\qnca050.prw
// Contem SOMENTE functions/methods cujo cabecalho ProtheusDoc lista willian.ramalho como autor.
// Este arquivo NAO e o fonte completo original.

/*/{Protheus.doc} QNCA050AuxClass
Classe agrupadora de métodos auxiliares do QNCA050

@author thiago.rover / willian.ramalho
@since 11/07/2025
/*/
CLASS QNCA050AuxClass FROM LongNameClass

	METHOD new() CONSTRUCTOR
	METHOD reposicionaNaLinhaDoListBoxAposRecriacaoDaTela(nNumFolder, nNumLine, oQI3, oQI5) 
	METHOD reposicionaNoFolderAposRecriacaoDaTela(nNumFolder, aQI5, aQI3, aQI2)
	METHOD reposicionaQI3NoPlanoDaEtapa(aQI5, nPos)

ENDCLASS


/*/{Protheus.doc} new
Cria uma nova instância da classe QNCA050AuxClass.

@author thiago.rover / willian.ramalho
@since 11/07/2025
@return Instância da classe QNCA050AuxClass.
/*/
METHOD new() CLASS QNCA050AuxClass
RETURN Self


/*/{Protheus.doc} reposicionaNaLinhaDoListBoxAposRecriacaoDaTela
Método responsável por posicionar na linha do ListBox

@author thiago.rover/willian.ramalho
@since 11/07/2025

@param nNumFolder, numerico, número do folder selecionado
@param nNumLine, numerico, número da linha para ser posicionada
@param oQI3, objeto, objeto do QI3
@param oQI5, objeto, objeto do QI5
@return Lógico, retorna sempre .T.
/*/
METHOD reposicionaNaLinhaDoListBoxAposRecriacaoDaTela(nNumFolder, nNumLine, oQI3, oQI5) CLASS QNCA050AuxClass

	IF nNumFolder == 1
		oQI5:nAt := nNumLine
		oQI5:Refresh(.T.)
	ELSEIF nNumFolder == 2
		oQI3:nAt := nNumLine
		oQI3:Refresh(.T.)
	ENDIF

RETURN .T.


/*/{Protheus.doc} reposicionaNoFolderAposRecriacaoDaTela
Método responsável por reposicionar no folder após a recriação da tela

@author thiago.rover/willian.ramalho
@since 11/07/2025

@param nNumFolder, numerico, número do folder selecionado
@param aQI5, array, array de dados do QI5
@param aQI3, array, array de dados do QI3
@param aQI2, array, array de dados do QI2
@return Numerico, retorna o número do folder a ser reposicionado
/*/
METHOD reposicionaNoFolderAposRecriacaoDaTela(nNumFolder, aQI5, aQI3, aQI2) CLASS QNCA050AuxClass

RETURN IF(nNumFolder == 0 ,;
                IF(!Empty(aQI5[1,1]),1,IF(!Empty(aQI3[1,1]),2,IF(!Empty(aQI2[1,1]),3,1))),;
		        nNumFolder)
