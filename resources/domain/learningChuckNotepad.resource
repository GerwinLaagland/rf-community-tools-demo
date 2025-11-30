*** Settings ***
Documentation       Domain keywords intended for Database component tests.

Resource            components/notepad.resource


*** Keywords ***
Chuck Has Windows Notepad Installed
    [Documentation]    Precondition check to ensure Chuck Norris can write into Notepad
    Verify Notepad Is Installed

He Writes A Text In Notepad
    [Documentation]    Action where Chuck writes a placeholder text into a txt file
    Start Notepad Application
    Write A Text    This is placeholder text.
    Save Notepad File And Close    chuckWritingFile

It Should Match A Template File
    [Documentation]    Verification that the created file should be the same as the template
    Sleep    1s
    ${resultFile}    Get File    ${OUTPUT_DIR}${/}desktop${/}chuckWritingFile.txt
    ${expectedFile}    Get File    ${CURDIR}${/}..${/}data${/}template.txt
    Should Be Equal    ${resultFile}    ${expectedFile}
