*** Settings ***
Documentation     Resource file with basic keywords.
Library           SeleniumLibrary
Library           Collections
Resource         ../Resources/Page Objects/AutomationPractice_PageObject.resource
Resource         ../Resources/TestData.resource

*** Keywords ***
Enter Information
    [Arguments]    ${locator}    ${value} 
    Input Text    ${locator}    ${value}

Click on button
    [Arguments]    ${locator}
    Click Element    ${locator}

Click Radio Button
    [Arguments]            ${locator}        ${option} 
    Select Radio Button    ${locator}        ${option} 
    

Toggle checkbox    
...    [arguments]      ${value}
        IF  '${value}' == '0'
            Unselect Checkbox   ${value}
        ELSE
            Select Checkbox    ${value}
        END






