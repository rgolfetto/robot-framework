*** Settings ***
Documentation     Resource file with basic keywords.
Library           SeleniumLibrary
Library           Collections
Library           String
Resource         ../Resources/Page Objects/AutomationPractice_PageObject.resource
Resource         ../Resources/TestData.resource

*** Keywords ***
Select Item From List With Index
    [Arguments]    ${locator}    ${index}
    Select From List By Index    ${locator}    ${index}

Select Value From List    
       [Arguments]    ${locator}    ${value}
       Select From List By Label    ${locator}    ${value}

Verify Duplicated Value in List
    [Arguments]    ${listLocator}
    List Should Not Contain Duplicates    ${listLocator}

List should contain
    [Arguments]    ${listLocator}    ${value}
    List Should Contain Value    ${listLocator}    ${value}

Add item to list
    [Arguments]    ${listLocator}    
    Append To List    ${listLocator}   

Remove item from list
    [Arguments]    ${listLocator}    ${itemIndex}
    Remove From List    ${listLocator}    ${itemIndex}

Get Element From List By Position     
    [Arguments]    ${locator}    ${position}      
    ${elements}=    Get WebElements     ${locator}
    ${element}=    Get From List    ${elements}    ${position}
    [Return]    ${element}

Click on Element From List By Position
    [Arguments]    ${locator}    ${position}
    ${element}=    Get Element From List By Position    ${locator}    ${position}
    Click Element    ${element}
    
Click on Element From List By Value
    [Arguments]    ${locator}    ${value}    
    ${element}=    Get Item From List By Value    ${locator}    ${value}    
    Click Element    ${element}

Get Item From List By Value
    [Arguments]    ${listLocator}    ${value}
    ${elements}=    Get WebElements    ${listLocator}
    FOR    ${element}    IN    @{elements}
        ${item}=    Get Text    ${element}
        Run Keyword If    '${item}' == '${value}'    Return From Keyword    ${element}
    END


    



    
    
