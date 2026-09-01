/*/{Protheus.doc} New
Construtor da classe - Inicializa propriedades e configurações

@type method
@author brunno.costa / willian.ramalho
@since 29/04/2026
@version 1.0

@param01 nRecnoQEK, numeric, Recno da inspeção na tabela QEK
@param02 cLaborat, character, Código do laboratório (vazio para todos)

@return Self, object, Instância da classe inicializada
/*/
METHOD New(nRecnoQEK, cLaborat) CLASS QIEPlanoAmostragem

    Default cLaborat  := ""
    Default nRecnoQEK := 0

    // Dados de entrada
    self:cLaborat  := AllTrim(cLaborat)
    self:cUsuario  := UsrRetName(RetCodUsr())
    self:nRecnoQEK := nRecnoQEK

    // Inicializa arrays
    self:aAcumAglut := {}
    self:aEnsaios   := {}
    self:aResultado := {}

    // Inicializa resultados
    self:cErro     := ""
    self:cMensagem := ""
    self:cParecer  := ""
    self:lSucesso  := .F.

    // Carrega configurações de parâmetros
    self:lAglutPlan := GetMV("MV_QACUPAM", .F., .F.)
    self:lAprConTol := GetMV("MV_QAPCTOL", .F., .T.) // Aprovação Condicional com Tolerância
    self:lBlqPlano  := (GetMV("MV_QBLQPLA", .F., "2") == "1")
    self:lMedForEsp := GetMV("MV_QERESNC", .F., .F.) // Medições Fora de Especificação como NC
    
    // Valida se existe Ponto de Entrada
    self:lQ215PINT := ExistBlock("Q215PINT")
    self:lQ215PL1  := ExistBlock("Q215PL1")
    self:lQ215PL2  := ExistBlock("Q215PL2")

Return Self
