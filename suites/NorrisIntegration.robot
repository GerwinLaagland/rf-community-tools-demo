*** Settings ***
Documentation       MultiLib Testing: API + Database + Desktop + Web Automation Demo

Resource            domain/learningChuckAPI.resource
Resource            domain/learningChuckDB.resource
Resource            domain/learningIntegration.resource

Suite Setup         Log To Console    Running Robot Framework multi-domain demo...
Suite Teardown      Log To Console    Demo complete.


*** Test Cases ***
Ultimate Chuck Norris Integration Test
    [Documentation]    Get Chuck Norris jokes API + DB + Desktop Automation + Web.
    [Tags]    multi-domain    api    database    desktop    web    orchestration

    Given Chuck's API Is Operational
    And Chuck's Database Is Prepared

    When Jokes Are Retrieved For Each Category From The API
    And Jokes Are Stored For Each Category Into Database

    Then Jokes Can Be Retrieved For Each Category From Database
    And Jokes Can Be Written For Each Category In A File
