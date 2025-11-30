*** Settings ***
Documentation       A collection of keywords used to control a windows notepad application.

Library             Collections
Library             OperatingSystem
Library             RPA.Desktop


*** Variables ***
${OUTPUT_LOCATION}      ${OUTPUT DIR}${/}desktop


*** Keywords ***
Verify Notepad Is Installed
    [Documentation]    Verifies that Notepad can be started (therefore is installed)
    Start Notepad Application
    RPA.Desktop.Press Keys    alt    f4

Start Notepad Application
    [Documentation]    Starts Notepad application and creates a new file
    Open Application    notepad.exe
    Sleep    2s
    # Open File menu to create a new file
    RPA.Desktop.Press Keys    ctrl    n
    Sleep    1s

Write Dictionary To Notepad
    [Documentation]    Writes selected jokes to Notepad
    [Arguments]    ${specific_jokes}
    RPA.Desktop.Type Text    Category: Selected Chuck Norris Joke\n
    Sleep    500ms
    Sleep    500ms

    FOR    ${entry}    IN    @{specific_jokes}
        RPA.Desktop.Type Text    ${entry.category}:${entry.text}\n
        Sleep    300ms
    END

Save Notepad File And Close
    [Documentation]    Saves the Notepad file with the given filename and closes Notepad
    [Arguments]    ${filename}
    [Setup]    Create Directory    ${OUTPUT_LOCATION}

    VAR    ${filename} =    ${OUTPUT_LOCATION}${/}${filename}
    Remove File    ${filename}.txt

    # Save the notepad file using File menu
    Log    Saving the Notepad file...
    # Open File menu and Save As using direct keyboard shortcut
    RPA.Desktop.Press Keys    ctrl    s

    # The Save As dialog should now be open
    # Clear any default filename and type the full path
    RPA.Desktop.Press Keys    ctrl    a
    Sleep    500ms

    # Type the full path with filename
    RPA.Desktop.Type Text    ${filename}

    # Press Enter to save
    RPA.Desktop.Press Keys    Enter

    # Close Notepad using ALT F4
    RPA.Desktop.Press Keys    alt    f4
    Sleep    500ms

Write A Text
    [Documentation]    Writes a text to a document, and optionally saves it.
    [Arguments]    ${text}
    Sleep    300ms
    RPA.Desktop.Type Text    ${text}
    Sleep    500ms
