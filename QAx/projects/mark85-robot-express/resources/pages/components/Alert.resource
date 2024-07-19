*** Settings ***
Documentation        Ações e elementos do componente de mensagens de alertas

Library        Browser

*** Keywords ***

Alert should be
    [Arguments]        ${expected_text}
    ${element}        Set Variable        css=.alert-error

                        
    Wait For Elements State    ${element} >> text=${expected_text}                    
    ...    visible    5
    Wait For Elements State    ${element} >> text=${expected_text}                             
    ...    visible    5
    Wait For Elements State    ${element} >> text=${expected_text}       
    ...    visible    5