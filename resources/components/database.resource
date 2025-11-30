*** Settings ***
Documentation       A collection of keywords used to control and handle the database component.

Library             OperatingSystem
Library             String
Library             DatabaseLibrary


*** Variables ***
${DB_API}           sqlite3    # database API
${DB_LOCATION}      ${OUTPUT DIR}${/}database
${DB_NAME}          ${DB_LOCATION}${/}demo.db    # database file name


*** Keywords ***
Prepare Chuck Norris Database
    [Documentation]    Prepares the database by removing existing file and creating jokes table
    ...    Primary key is separate from other columns
    ...    Example: Prepare Chuck Norris Database    id INTEGER    category TEXT    text TEXT
    [Arguments]    ${primary_key}    @{other_columns}
    [Setup]    Create Directory    ${DB_LOCATION}
    Remove File    ${DB_NAME}
    Connect To Database    ${DB_API}    ${DB_NAME}

    # Use default columns if none provided
    IF    ${other_columns} == @{EMPTY}
        VAR    @{other_columns} =    category TEXT    text TEXT
    END

    # Build the CREATE TABLE statement with PRIMARY KEY as separate constraint
    ${columns_sql} =    Catenate    SEPARATOR=,${SPACE}    @{other_columns}

    Execute Sql String    CREATE TABLE JOKES (${primary_key} PRIMARY KEY, ${columns_sql});

Save Jokes To Database
    [Documentation]    Saves Chuck Norris jokes to the database by parsing category and text from each entry.
    ...    It expects a jokes dictionary.
    [Arguments]    ${jokes}
    Log    ${jokes}
    FOR    ${entry}    IN    @{jokes}
        # Escape single quotes for SQL by replacing ' with ''
        ${joketxt_escaped} =    Replace String    ${jokes.${entry}}    '    ''
        Execute Sql String    INSERT INTO jokes(category, text) VALUES ('${entry}', '${joketxt_escaped}');
    END

Query Chuck Norris Database
    [Documentation]    Queries jokes from the database, optionally filtering by category
    [Arguments]    ${search_category}=all

    IF    '${search_category}' == 'all'
        ${db_jokes} =    Query    SELECT category, text FROM JOKES;    return_dict=${True}
    ELSE
        ${db_jokes} =    Query
        ...    SELECT category, text FROM JOKES WHERE category='${search_category}';
        ...    return_dict=${True}
    END

    RETURN    ${db_jokes}

Disconnect From Chuck Norris Database
    [Documentation]    Disconnects from the Chuck Norris database
    Disconnect From Database
