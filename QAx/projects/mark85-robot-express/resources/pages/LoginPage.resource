*** Settings ***
Documentation        Ações e elementos da página de login

Library        Browser
Library        String

*** Keywords ***
Submit login form
    [Arguments]        ${user}
    Fill Text        css=input[placeholder$=mail]        ${user}[email]
    Fill Text        css=input[placeholder=Senha]        ${user}[password]

    Click        css=button >> text=Entrar

User should be logged in
    [Arguments]        ${name}
    
    @{splited_name}       Split String        ${name}
    ${element}            Set Variable        css=header .right small

    Wait For Elements State        ${element}    
    ...        visible         5
    Get Text        ${element}        equal    Olá, ${splited_name}[0]