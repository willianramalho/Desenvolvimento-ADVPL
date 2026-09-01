/*/{Protheus.doc} TrataGetMv
Função responsável por tratar o retorno da função GetMv removendo as aspas duplas que são adicionadas quando o parâmetro já é do tipo string.
@author willian.ramalho
@since  17/03/2026
@version 1.0
@param  cParam, caracter, retorno da função GetMv para o parâmetro a ser tratado
@return cValor, caracter, Conteúdo do parâmetro sem aspas duplas extras
/*/
Function TrataGetMv(cParam)

    Local cValor := cParam

    If Left(cValor, 1) == '"' .And. Right(cValor, 1) == '"'
        cValor := SubStr(cValor, 2, Len(cValor) - 2)
    EndIf

Return cValor
