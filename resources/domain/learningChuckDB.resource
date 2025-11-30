*** Settings ***
Documentation       Domain keywords intended for Database component tests.

Library             Collections
Resource            components/database.resource


*** Keywords ***
Chuck's Database Is Prepared
    [Documentation]    Verifies that Chuck's database exists and the jokes table is available
    Prepare Chuck Norris Database    id INTEGER    category TEXT    text TEXT
    Connect To Database    ${DB_API}    ${DB_NAME}    alias=ChuckDB
    ${tables}=    Query    SELECT name FROM sqlite_master WHERE type='table' AND name='JOKES';
    Length Should Be    ${tables}    1

Jokes Are Stored In Chuck's Database
    [Documentation]    Inserts a placeholder record to ensure database table has been correctly made
    Switch Database    ChuckDB
    Execute Sql String
    ...    INSERT INTO JOKES(category, text) VALUES ('placeholder', 'This would be a Chuck Norris Joke');

Jokes Should Be Retrievable
    [Documentation]    Retrieves stored information from the Chuck Database, to verify information is retrievable
    Switch Database    ChuckDB
    ${result}=    Query    SELECT * FROM JOKES    return_dict=${True}
    Length Should Be    ${result}    1
