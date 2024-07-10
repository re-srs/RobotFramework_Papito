*** Settings ***
Documentation        Cenários de testes do cadastro de usuários

Library        FakerLibrary

Resource        ../resources/base.robot

Test Setup        Start Session
Test Teardown     Take Screenshot


*** Test Cases ***
Deve poder cadastrar um novo usuário

    ${user}        Create Dictionary        
    ...    name=Renata Lobato        
    ...    email=renata@gmail.com        
    ...    password=123456    

    Remove user from database    ${user}[email]

    Go To    http://localhost:3000/signup

    # Checkpoint
    Wait For Elements State        css=h1        visible     5
    Get Text                       css=h1        equal       Faça seu cadastro

    Fill Text    id=name         ${user}[name]
    Fill Text    id=email        ${user}[email]
    Fill Text    id=password     ${user}[password]

    Click        id=buttonSignup

    Wait For Elements State    css=.notice p   visible    5
    Get Text                   css=.notice p   equal      Boas vindas ao Mark85, o seu gerenciador de tarefas.

Não deve permitir o cadastro com email duplicado
    [Tags]    dup

    ${user}        Create Dictionary        
    ...    name=Lobato Renata       
    ...    email=renata@gmail.com        
    ...    password=123456   

    #pre condição é inserir o registro antes para que tenha duplicidade ao testar
    Remove user from database    ${user}[email]
    Insert user from database    ${user}
    
    Go To    http://localhost:3000/signup

    # Checkpoint
    Wait For Elements State        css=h1        visible     5
    Get Text                       css=h1        equal       Faça seu cadastro

    Fill Text    id=name         ${user}[name]
    Fill Text    id=email        ${user}[email]
    Fill Text    id=password     ${user}[password]

    Click        id=buttonSignup

    Wait For Elements State    css=.notice p   visible    5
    Get Text                   css=.notice p   equal      Oops! Já existe uma conta com o e-mail informado.

