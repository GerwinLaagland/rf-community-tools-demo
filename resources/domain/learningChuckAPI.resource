*** Settings ***
Documentation       Domain keywords intended for API component tests.

Library             Collections
Resource            components/api.resource


*** Variables ***
@{CHUCK_ACTUAL_CATEGORIES}      @{EMPTY}
@{CHUCK_EXPECTED_CATEGORIES}
...                             animal
...                             career
...                             celebrity
...                             dev
...                             explicit
...                             fashion
...                             food
...                             history
...                             money
...                             movie
...                             music
...                             political
...                             religion
...                             science
...                             sport
...                             travel


*** Keywords ***
Chuck's API Is Operational
    [Documentation]    A verification to ensure that the Categories endpoint works.
    Verify Chuck Norris Categories Endpoint Is Functioning

The List Of Joke Categories Is Retrieved From Chuck's API
    [Documentation]    Retrieves a list of all categories and stores them in SUITE variable.
    ${categories} =    Get Chuck Norris Joke Categories
    ${jokes} =    Get Jokes Per Category    ${categories}
    ${numJokes} =    Get Length    ${jokes}
    IF    not $numJokes    Fail    No jokes fetched!
    VAR    @{CHUCK_ACTUAL_CATEGORIES} =    @{categories}    scope=SUITE

The List Of Categories Should Match The Expected Categories
    [Documentation]    Compare Retrieved And Listed Categories and ensure they are equal.
    Lists Should Be Equal    ${CHUCK_ACTUAL_CATEGORIES}    ${CHUCK_EXPECTED_CATEGORIES}
