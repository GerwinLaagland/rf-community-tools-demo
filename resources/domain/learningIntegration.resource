*** Settings ***
Documentation       Domain keywords intended for integration tests that are connected to component keywords.

Resource            components/api.resource
Resource            components/database.resource
Resource            components/notepad.resource


*** Variables ***
&{JOKES_API_OVERVIEW}       &{EMPTY}
&{JOKES_DB_OVERVIEW}        &{EMPTY}


*** Keywords ***
Jokes Are Retrieved For Each Category From The API
    [Documentation]    Retrieves Joke categories, and fetches one of each, and stores these in 'JOKES_API_OVERVIEW'
    ${categories}=    Get Chuck Norris Joke Categories
    ${jokesDict}=    Get Jokes Per Category    ${categories}
    Set To Dictionary    ${JOKES_API_OVERVIEW}    &{jokesDict}

Jokes Are Stored For Each Category Into Database
    [Documentation]    Insert jokes stored in 'JOKES_API_OVERVIEW' in local database.
    Save Jokes To Database    ${JOKES_API_OVERVIEW}

Jokes Can Be Retrieved For Each Category From Database
    [Documentation]    All jokes stored in database will be retrieved and set to a Suite scoped var 'JOKES_DB_OVERVIEW'
    ${results}=    Query Chuck Norris Database    all
    VAR    ${JOKES_DB_OVERVIEW}=    ${results}    scope=SUITE

Jokes Can Be Written For Each Category In A File
    [Documentation]    For all items stored in global 'JOKES_DB_OVERVIEW' a line will be written in notepad file.
    Start Notepad Application
    Write Dictionary To Notepad    ${JOKES_DB_OVERVIEW}
    Save Notepad File And Close    norris_integration_jokes
