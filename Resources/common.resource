*** Settings ***
Documentation     Resource file with basic keywords.
Library    SeleniumLibrary
Library    Collections
Library    XML

*** Keywords ***
Enter information    
...    [arguments]    ${locator}    ${text} 
        Input Text    ${locator}    ${text}

Select Radio Option    
...    [arguments]    ${locator}        ${value}
        Select Radio Button    ${locator}        ${value} 

Select or unselect checkbox    
...    [arguments]      ${value}
        IF  '${value}' == '0'
            Unselect Checkbox   ${value}
        ELSE
            Select Checkbox    ${value}
        END

Row count
    [Arguments]    ${tableLocator}      
    ${rowCount}=    SeleniumLibrary.Get Element Count    ${tableLocator}
    log to console  ${rowCount}

Column count
    [Arguments]    ${tableLocator}      
    ${colCount}=    SeleniumLibrary.Get Element Count    ${tableLocator}
    log to console  ${colCount}

Get cell
    [Arguments]    ${tableLocator}    ${row}    ${col}
    ${tableCell}=    Get Table Cell    ${tableLocator}   ${row}    ${col}
    log to console      ${tableCell}

Click on Header
    [Arguments]        ${tableLocator}    
    Click Element    ${tableLocator}   

Click on Cell
    [Arguments]        ${tableLocator}    ${row}    ${col}
    Click Element    ${tableLocator}    ${row}    ${col}

Cell should contain
    [Arguments]    ${tableLocator}    ${row}    ${col}    ${expectedValue}
    Table Cell Should Contain    ${tableLocator}    ${row}    ${col}    ${expectedValue}

Row should contain
    [Arguments]    ${tableLocator}    ${row}    ${col}    ${expectedValue}
    Table Row Should Contain    ${tableLocator}    ${row}    ${col}    ${expectedValue}

Header should contain
    [Arguments]    ${tableLocator}    ${expectedValue}
    Table Header Should Contain    ${tableLocator}    ${expectedValue}

Select Item From List With Index
    [Arguments]    ${locator}    ${index}
    Select From List By Index    ${locator}    ${index}

Verify Duplicated Elements in List
    [Arguments]    ${listVariable}
    List Should Not Contain Duplicates    ${listVariable}






