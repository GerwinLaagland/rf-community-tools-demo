*** Settings ***
Documentation       An example of a technical testcase without the 'domain' layer.

Resource            components/api.resource
Resource            components/database.resource
Resource            components/notepad.resource
Resource            components/browser.resource


*** Test Cases ***
Meet Chuck
    [Documentation]    Introducing Chuck Norris By Visiting A Google Image Page
    Open Google Search Browser    https://www.google.com/?hl=el
    Make Google Image Search    Chuck Norris

Write Some Of Chuck API's To File
    [Documentation]    A technical action word oriented notation for the integration test
    ${categories} =    Get Chuck Norris Joke Categories
    ${jokesAPI} =    Get Jokes Per Category    ${categories}
    Prepare Chuck Norris Database    id INTEGER    category TEXT    text TEXT
    Save Jokes To Database    ${jokesAPI}
    ${jokesDB} =    Query Chuck Norris Database    all
    Disconnect From Chuck Norris Database
    Start Notepad Application
    Write Dictionary To Notepad    ${jokesDB}
    Save Notepad File And Close    chuck_system_jokes
