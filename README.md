# robot-framework

Hey, I'm learning robot framework.

For learning purposes we'll be using the space separated format:

*** Settings ***
Documentation     Example using the space separated format.
Library           OperatingSystem

*** Variables ***
${MESSAGE}        Hello, world!

*** Test Cases ***
My Test
    [Documentation]    Example test.
    Log    ${MESSAGE}
    My Keyword    ${CURDIR}

Another Test
    Should Be Equal    ${MESSAGE}    Testing message

*** Keywords ***
My Keyword
    [Arguments]    ${path}
    Directory Should Exist    ${path}

