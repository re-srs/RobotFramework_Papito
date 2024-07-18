*** Settings ***
Documentation        Cenários de testes do cadastro de usuários

Library        FakerLibrary

Resource        ../resources/base.resource

Test Setup        Start Session
Test Teardown     Take Screenshot


*** Test Cases ***
Deve poder cadastrar um novo usuário

    ${user}        Create Dictionary        
    ...    name=Renata Lobato        
    ...    email=renata@gmail.com        
    ...    password=123456    

    Remove user from database    ${user}[email]

    Go To signup page
    Submit signup form    ${user}
    Notice should be      Boas vindas ao Mark85, o seu gerenciador de tarefas.

Não deve permitir o cadastro com email duplicado
    [Tags]    dup

    ${user}        Create Dictionary        
    ...    name=Lobato Renata       
    ...    email=renata@gmail.com        
    ...    password=123456   

    #pre condição é inserir o registro antes para que tenha duplicidade ao testar
    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Go To signup page
    Submit signup form    ${user}
    Notice should be      Oops! Já existe uma conta com o e-mail informado.

Campos obrigatórios
    [Tags]    required

    ${user}    Create Dictionary
    ...    name=${EMPTY}    
    ...    email=${EMPTY}    
    ...    password=${EMPTY}
      
    Go To signup page
    Submit signup form    ${user}

    Alert should be    Informe seu nome completo    
    Alert should be    Informe seu e-email 
    Alert should be    Informe uma senha com pelo menos 6 digitos

Não deve cadastrar com email incorreto
    [Tags]    email_incorreto

    ${user}    Create Dictionary
    ...    name=Joao Batista    
    ...    email=joao.batista.com    
    ...    password=123456
      
    Go To signup page
    Submit signup form    ${user}
    Alert should be    Digite um e-mail válido

#testa todos cenários abrindo o navegador somente uma vez
Não deve cadastrar com senha muito curta
    [Tags]    temp
    @{password_list}    Create List    1    12    123    1234    12345

    FOR    ${password}    IN    @{password_list}
                ${user}    Create Dictionary
    ...    name=Joao Batista    
    ...    email=joao.batista@gmail.com    
    ...    password=${password}
      
    Go To signup page
    Submit signup form    ${user}
    Alert should be       Informe uma senha com pelo menos 6 digitos
        
    END

Não deve cadastrar com senha de 1 digito
    [Tags]    short_password
    [Template]
    Short password    1
Não deve cadastrar com senha de 2 digitos
    [Tags]    short_password
    [Template]
    Short password    12

Não deve cadastrar com senha de 3 digitos
    [Tags]    short_password
    [Template]
    Short password    123

Não deve cadastrar com senha de 4 digitos
    [Tags]    short_password
    [Template]
    Short password    1234

Não deve cadastrar com senha de 5 digitos
    [Tags]    short_password
    [Template]
    Short password    12345
    
    
*** Keywords ***
Short password
    [Arguments]    ${short_pass}

        ${user}    Create Dictionary
    ...    name=Joao Batista    
    ...    email=joao.batista@gmail.com    
    ...    password=${short_pass}
      
    Go To signup page
    Submit signup form    ${user}
    Alert should be       Informe uma senha com pelo menos 6 digitos

