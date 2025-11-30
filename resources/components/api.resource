*** Settings ***
Documentation       A collection of keywords used to interact with the chucknorris API.

Library             Collections
Library             RequestsLibrary


*** Variables ***
${BASE_URL}             https://api.chucknorris.io
${CATEGORIES_URL}       ${BASE_URL}/jokes/categories    # categories API endpoint
${JOKE_URL}             ${BASE_URL}/jokes/random?category=    # joke API endpoint


*** Keywords ***
Verify Chuck Norris Categories Endpoint Is Functioning
    [Documentation]    Check after opening a session if the Categories endpoint is still functioning.
    Create Session    chuck    ${BASE_URL}    verify=${True}
    ${response} =    GET On Session    chuck    /jokes/categories
    Should Be Equal As Integers    ${response.status_code}    200

Get Chuck Norris Joke Categories
    [Documentation]    Access Chuck Norris API to get categories and fetch a random joke from each category
    Create Session    chuck    ${CATEGORIES_URL}    verify=${True}
    ${response} =    GET On Session    chuck    /
    Should Be Equal As Integers    ${response.status_code}    200

    VAR    ${categories} =    ${response.json()}
    RETURN    ${categories}

Get Jokes Per Category
    [Documentation]    Fetches a random Chuck Norris joke from each category
    [Arguments]    ${categories}
    # Take a random joke from every category
    VAR    &{jokes} =    &{EMPTY}

    FOR    ${cat}    IN    @{categories}
        VAR    ${cat_url} =    ${JOKE_URL}${cat}
        ${joke_response} =    GET    ${cat_url}
        VAR    ${joke} =    ${joke_response.json()['value']}
        Set To Dictionary    ${jokes}    ${cat}=${joke}
    END

    RETURN    ${jokes}

Choose Category
    [Documentation]    Chooses a category based on the active profile or randomly
    ...    If profile is 'dev' or 'science', use that category; else random.
    [Arguments]    ${categories}

    IF    '${CATEGORY}' == 'dev'
        VAR    ${specific_category} =    dev
    ELSE IF    '${CATEGORY}' == 'science'
        VAR    ${specific_category} =    science
    ELSE
        ${specific_category} =    Evaluate    random.choice($categories)    modules=random
    END

    RETURN    ${specific_category}
