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
