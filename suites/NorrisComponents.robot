*** Settings ***
Documentation       Component tests that include a domain layer.

Resource            domain/learningChuckAPI.resource
Resource            domain/learningChuckDB.resource
Resource            domain/learningChuckNotepad.resource


*** Test Cases ***
Check Chuck's API
    [Documentation]    Introducing the API component, verifying the presence of categories
    Given Chuck's API Is Operational
    When The List Of Joke Categories Is Retrieved From Chuck's API
    Then The List Of Categories Should Match The Expected Categories

Check Chuck's Database
    [Documentation]    Introducing the Database component, verifying that it functions
    Given Chuck's Database Is Prepared
    When Jokes Are Stored In Chuck's Database
    Then Jokes Should Be Retrievable
    [Teardown]    Disconnect From All Databases

Check Chuck's Notepad
    [Documentation]    Introducing notepad component, verifying that it functions
    Given Chuck Has Windows Notepad Installed
    When He Writes A Text In Notepad
    Then It Should Match A Template File
