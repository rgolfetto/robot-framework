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
    [Arguments]    ${tableLocator}    ${expectedValue}    ${expectedCol}
    ${rowCount}=    Get Element Count    ${tableLocator} tr
    ${result}=    Create List

    FOR    ${row}    IN RANGE    1    ${rowCount+1}
        ${cellLocator}=    Set Variable    css:tr:nth-child(${row}) td:nth-child(${expectedCol})
        ${cellValue}=    Get Text    ${cellLocator}
        IF    '${cellValue}' == '${expectedValue}'
            Append To List    ${result}    [${cellValue}, ${row}, ${expectedCol}]
        END
    END
    [Return]    ${result}



Validate Value in Table Cell
    [Arguments]    ${tableLocator}    ${expectedValue}    ${expectedCol}    ${expectedRow}
    ${cellLocator}=    Set Variable    css:tr:nth-child(${expectedRow}) td:nth-child(${expectedCol})
    ${actualValue}=    Get Text    ${cellLocator}

    Run Keyword If    '${actualValue}' == '${expectedValue}'
    ...    Log    Value ${expectedValue} found in row ${expectedRow}, column ${expectedCol}
    ...    ELSE
    ...    Fail    Value ${expectedValue} not found in row ${expectedRow}, column ${expectedCol}

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
    ...    ELSE    Fail    Could not locate the checkbox
    Log    Checked checkbox for: ${valueToFind}

Validate Table Cell Value
    [Arguments]    ${tableLocator}    ${row}    ${column}    ${expectedValue}
    ${cell}=    Get Text    xpath=//table[@'${tableLocator}']/tbody/tr[${row}]/td[${column}]
    Run Keyword If    '${cell}' == ''    Fail    Table cell is empty
    Run Keyword If    '${cell}' != '${expectedValue}'    Fail    The values are different: ${cell} != ${expectedValue}
    Log    Validation passed for cell: ${cell} == ${expectedValue}

Select Page by Number
    [Arguments]    ${tableLocator}    ${pageNumber}
    ${pageLocator}=    Set Variable    xpath=//*[@id="${tableLocator}"]/li[${pageNumber}]/a
    ${pageExists}=    Run Keyword And Return Status    Element Should Be Visible    ${pageLocator}
    
    Run Keyword If    ${pageExists}    Select Page    ${pageLocator}    ${pageNumber}
    ...    ELSE
    ...    Fail    Page ${pageNumber} not found in the pagination table

Select Page
    [Arguments]    ${pageLocator}    ${pageNumber}
    Click Element    ${pageLocator}
    Log    Page ${pageNumber} selected

Get Cell Value by Header and Value
    [Arguments]    ${header}    ${value}    ${tableLocator}
    ${colIndex}=    Get Column Index by Header    ${header}
    ${rowsWithoutHeader}=    Get WebElements    ${tableLocator}//tr[th] #Change the path when necessary
    ${rowCount}=    Get Length    ${rowsWithoutHeader}
    ${rowIndex}=    Set Variable    -1
    FOR    ${index}    IN RANGE    ${rowCount}
        ${cellValue}=    Get Text    xpath=${tableLocator}//tr[${index + 1}]//th[${colIndex + 1}] #Change the path when necessary
        Run Keyword If    '${cellValue}' == '${value}'    Set Variable    ${rowIndex}    ${index + 1}
    END
    [Return]    ${rowIndex}

Get Column Index by Header
    [Arguments]    ${header}
    ${headerXpath}=    Get Xpath For Table Header    ${header}
    ${colIndex}=    Get Element Count    ${headerXpath}//preceding-sibling::th
    [Return]    ${colIndex + 1}    # Adding 1 as the index starts from 1 in Robot Framework

Get Xpath For Table Header
    [Arguments]    ${header}
    [Return]    xpath=${WEBTABLELOCATOR}//th[contains(.,'${header}')] | //th//a[contains(.,'${header}')]



