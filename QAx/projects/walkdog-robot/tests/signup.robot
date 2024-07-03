*** Settings ***
Documentation        Suite de testes dde cadastro de dog walker

Resource        ../resources/base.resource     

Test Setup       Start session
Test Teardown    Finish session

*** Test Cases ***
Deve poder cadastrar um novo dog walker
    [Tags]    smoke
    
    ${dog_walker}    Create Dictionary
    ...    name=Renata Lobato        
    ...    email=renataglbmelo@gmail.com
    ...    cpf=65087882560
    ...    cep=04534011
    ...    rua=Rua Joaquim Floriano
    ...    bairro=Itaim Bibi
    ...    cidade=São Paulo/SP
    ...    numero=100
    ...    complemento=Apto 28
    ...    cnh=toretto.jpg

    Go to signup page
    Fill signup form    ${dog_walker}
    Submit signup form
    Popup shoulde be    Recebemos o seu cadastro e em breve retornaremos o contato.


Não deve cadastrar se os campos obrigatórios não forem preenchidos
    [Tags]    required

    Go to signup page
    Submit signup form

    Alert should be    Informe o seu nome completo
    Alert should be    Informe o seu melhor email
    Alert should be    Informe o seu CPF
    Alert should be    Informe o seu CEP
    Alert should be    Informe um número maior que zero
    Alert should be    Adcione um documento com foto (RG ou CHN)


Não deve cadastrar se o cpf for incorreto
    [Tags]    cpf_inv

    ${dog_walker}    Create Dictionary
    ...    name=Renata Lobato        
    ...    email=renataglbmelo@gmail.com
    ...    cpf=650878825aa
    ...    cep=04534011
    ...    rua=Rua Joaquim Floriano
    ...    bairro=Itaim Bibi
    ...    cidade=São Paulo/SP
    ...    numero=100
    ...    complemento=Apto 28
    ...    cnh=toretto.jpg

    Go to signup page
    Fill signup form    ${dog_walker}
    Submit signup form
    Alert should be    CPF inválido

Deve poder cadastrar um novo dog walker que sabe cuidar de pets
    [Tags]    aservice
    
    ${dog_walker}    Create Dictionary
    ...    name=Jony Toretto       
    ...    email=jony@gmail.com
    ...    cpf=76326326974
    ...    cep=04534011
    ...    rua=Rua Joaquim Floriano
    ...    bairro=Itaim Bibi
    ...    cidade=São Paulo/SP
    ...    numero=100
    ...    complemento=Apto 28
    ...    cnh=toretto.jpg

    Go to signup page
    Fill signup form    ${dog_walker}
    Additional Service    Cuidar
    Submit signup form
    Popup shoulde be    Recebemos o seu cadastro e em breve retornaremos o contato.

Deve poder cadastrar um novo dog walker que sabe adestrar de pets
    [Tags]    aservice
    
    ${dog_walker}    Create Dictionary
    ...    name=Jony Toretto       
    ...    email=jony@gmail.com
    ...    cpf=76326326974
    ...    cep=04534011
    ...    rua=Rua Joaquim Floriano
    ...    bairro=Itaim Bibi
    ...    cidade=São Paulo/SP
    ...    numero=100
    ...    complemento=Apto 28
    ...    cnh=toretto.jpg

    Go to signup page
    Fill signup form    ${dog_walker}
    Additional Service    Adestrar
    Submit signup form
    Popup shoulde be    Recebemos o seu cadastro e em breve retornaremos o contato.






 