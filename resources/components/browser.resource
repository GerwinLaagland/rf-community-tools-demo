*** Settings ***
Documentation       A collection of keywords used to navigate through a browser UI component.

Library             Browser


*** Keywords ***
Open Google Search Browser
    [Documentation]    Opens Google homepage and handles consent popup if present
    [Arguments]    ${url}
    New Browser    browser=chromium    headless=False
    Set Browser Timeout    30s
    # Create a new context with viewport size and download support
    New Context    viewport={'width': 1920, 'height': 1080}    acceptDownloads=True
    New Page    ${url}

    # Handle consent popup if it appears
    TRY
        Browser.Wait For Elements State    div.QS5gu.sy4vM >> nth=1    visible    timeout=3s
        Browser.Click    div.QS5gu.sy4vM >> nth=1
    EXCEPT
        Log    No consent popup found or already accepted    level=DEBUG
    END

Make Google Image Search
    [Documentation]    Performs a Google Image search for the given term and takes a screenshot of the results
    [Arguments]    ${search_term}
    Wait For Elements State    a:text("Εικόνες")    visible
    Browser.Click    a:text("Εικόνες")

    # Now search on Google Images
    Wait For Elements State    textarea[name="q"]    visible
    Fill Text    textarea[name="q"]    ${search_term}
    Browser.Press Keys    textarea[name="q"]    Enter

    Wait For Load State    networkidle
    Browser.Take Screenshot    chuck_norris_images.png

    VAR    ${top_result} =    Screenshot saved: chuck_norris_images.png

    RETURN    ${top_result}
