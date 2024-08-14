*** Settings ***
Documentation        Cenários de cadastro de tarefas

Library        JSONLibrary

Resource        ../../resources/base.resource

Test Setup        Start Session
Test Teardown     Take Screenshot

*** Test Cases ***

Deve poder cadastrar uma nova tarefa

    ${data}    Get fixture    tasks    create

    Clean user from database    ${data}[user][email]
    Insert user from database    ${data}[user]


    Submit login form           ${data}[user]
    User should be logged in    ${data}[user][name]

    Go to task form
    Submit task form        ${data}[task]

    Sleep    5

    Log    ${data}