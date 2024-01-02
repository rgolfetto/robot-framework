*** Settings ***
Documentation     Resource file with basic keywords.
Library           BuiltIn
Library           SeleniumLibrary
Library           Collections
Resource         ../Resources/Page Objects/AutomationPractice_PageObject.resource
Resource         ../Resources/TestData.resource

*** Keywords ***
Row count
    [Arguments]    ${tableLocator}      
    ${rowCount}=    SeleniumLibrary.Get Element Count    ${tableLocator}
    [Return]  ${rowCount}

Column count
    [Arguments]    ${tableLocator}      
    ${colCount}=    SeleniumLibrary.Get Element Count    ${tableLocator}
    [Return]  ${colCount}

Get cell by position
    [Arguments]    ${tableLocator}    ${row}    ${col}
    ${tableCell}=    Get Table Cell    ${tableLocator}    ${row}    ${col}
    [Return]    ${tableCell}

Header Click
    [Arguments]        ${tableLocator}    
    Click Element    ${tableLocator}   

Click on Cell
    [Arguments]        ${tableLocator}    ${row}    ${col}
    Click Element    ${tableLocator}    ${row}    ${col}

Table Cell Contains
    [Arguments]    ${tableLocator}    ${row}    ${col}    
    Table Should Contain   ${tableLocator}    ${row}    ${col}    

Row should contain
    [Arguments]    ${tableLocator}    ${row}    ${col}    ${expectedValue}
    Table Row Should Contain    ${tableLocator}    ${row}    ${col}    ${expectedValue}

Table Header should contain
    [Arguments]    ${tableLocator}    ${expectedValue}
    Table Header Should Contain    ${tableLocator}    ${expectedValue}

Get Table Cell By Value
    [Arguments]    ${tableLocator}    ${expectedValue}
    ${rowCount}=    Get Element Count    ${tableLocator} tr
    ${colCount}=    Get Element Count    ${tableLocator} th
    ${result}=    Create List

    FOR    ${row}    IN RANGE    1    ${rowCount+1}
        ${currentRow}=    Set Variable    ${row}
        FOR    ${col}    IN RANGE    1    ${colCount+1}
            ${currentColInLoop}=    Set Variable    ${col}
            ${cellLocator}=    Set Variable    css:tr:nth-child(${row}) td:nth-child(${col})
            ${cellValue}=    Get Text    ${cellLocator}
            IF    '${cellValue}' == '${expectedValue}'
                Append To List    ${result}    [${cellValue}, ${currentRow}, ${currentColInLoop}]
            END
        END
    END
    [Return]    ${result}

Validate If Table Cell Have The Expected Value
    [Arguments]    ${value}
    ${result}=    Get Table Cell By Value    ${WEBTABLELOCATOR}    ${value}
    FOR    ${list}    IN    @{result}
        Log Many    Value exists in: ${list[0]} at row ${list[1]}, column ${list[2]}
    END

Get Pagination Table Page Elements
    [Arguments]    ${locator}
    ${pageElements}=    Get WebElements    ${locator}
    [Return]    ${pageElements}

Click Page In Pagination Table
    [Arguments]    ${locator}    ${pageNumber}
    ${pageElements}=    Get Pagination Table Page Elements    ${locator}
    ${pageNumberInteger}=    Convert To Integer    ${pageNumber}
    ${pageNumberElement}=    Get From List    ${pageElements}    ${pageNumberInteger - 1}
    Click Element    ${pageNumberElement}

Change Page In Pagination Table
    [Arguments]    ${locator}    ${targetPage}
    Click Page In Pagination Table    ${locator}    ${targetPage}

Toggle Checkbox Based on Value in Table
    [Arguments]    ${tableId}    ${valueToFind}    ${tdPosition}
    ${checkboxLocator}=    Set Variable    //*[@id="${tableId}"]/tbody/tr[td[contains(text(),"${valueToFind}")]]/td[${tdPosition}]/input
    ${checkboxExists}=    Run Keyword And Return Status    Page Should Contain Element    ${checkboxLocator}
    Run Keyword If    '${checkboxExists}' == 'True'  Select Checkbox    ${checkboxLocator}
    Log    Checked checkbox for: ${valueToFind}

Validate Table Cell Value
    [Arguments]    ${tableLocator}    ${row}    ${col}
    ${cell}=    Get Text    //*[@name="${tableLocator}"]/tbody/tr[${row}]/td[${col}]
    Run Keyword If    '${cell}' == ''    Fail    Table cell is empty
    [Return]    ${cell}
