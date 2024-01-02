*** Settings ***
Documentation      Basic tests
Library            SeleniumLibrary
Library            Collections
Library            DateTime
Resource          ../../Resources/TestData.resource
Resource           ../common.resource
Resource           ../lists.resource
Resource           ../tables.resource

*** Variables ***
${NAMEID}                      id=name
${EMAILID}                     id=email
${PHONEID}                     id=phone
${ADRESSID}                    id=textarea
${SUBMITBUTTON}                class=buttons_reverse .submit_button
${GENDEROPTIONS}               gender
${CHECKBOXSUNDAY}              id=sunday
${CHECKBOXTHURSDAY}            id=thursday
${WEBTABLELOCATOR}             class=widget-content > table
${ROWCOUNT}                    xpath://table[@name='BookTable']/tbody/tr
${COLCOUNT}                    xpath://table[@name='BookTable']/tbody/tr[1]/th  
${GETCOUNTRYVALUES}            id=country

${DAYSLOCATORINPUT}            class=post-body.entry-content > .form-group:nth-of-type(4) label ~ div input
${DAYSLOCATOR}                 class=post-body.entry-content > .form-group:nth-of-type(4) label ~ div
${BOOKTABLENAME}               BookTable
${COLORSLIST}                  id=colors
${ABTESTINGLINK}               class=large-12 > ul > li:nth-child(1) > a
${PAGINATIONTABLEPAGE}         class=pagination > li
${PAGINATIONTABLE}             productTable
${FRAMELOCATOR}                class=widget-content iframe#frame-one796456169
${TDPOSITION}                  4
${VALUETOFIND}                 Product 14

*** Keywords ***
Open Browser, Maximize and navigate to URL
       Open Browser    https://testautomationpractice.blogspot.com    headlesschrome
       Maximize Browser Window

Navigate to another page
       Go To        https://the-internet.herokuapp.com/
       Wait Until Element Contains        ${ABTESTINGLINK}        A/B Testing
       Page Should Contain Link    ${ABTESTINGLINK}
       
Click AB Testing Link
        Click Element    ${ABTESTINGLINK}

Enter name  
    [Arguments]    ${name}
    Input Text   ${NAMEID}   ${name}

Enter email
    [Arguments]    ${email}
    Input Text   ${EMAILID}  ${email}

Enter phone number
    [Arguments]    ${phone}
    Input Text   ${PHONEID}  ${phone}

Enter address
    [Arguments]    ${address}
    Input Text   ${ADRESSID}  ${address}

Click Submit
    Select Frame      ${FRAMELOCATOR}
    Click on button   ${SUBMITBUTTON}
    Unselect Frame

Select Gender
        [Arguments]    ${option}    
        Click Radio Button    ${GENDEROPTIONS}        ${option}  

Validate text on page
    [Arguments]    ${text}
    Wait Until Page Contains    ${text}

###  Tables  ### 
Validate If Table Cell Have Any Value In Selected Row and Column
    [Arguments]    ${row}    ${col}
    ${actualValue}=    Get cell by position    ${WEBTABLELOCATOR}    ${row}    ${col}
    Validate Table Cell Value    ${BOOKTABLENAME}    ${row}    ${col}            
    Log    Actual value in the cell: ${actualValue}

Validate If Table Cell Have The Especified Value
    [Arguments]    ${value}
    Get Table Cell By Value    ${WEBTABLELOCATOR}    ${value}
    Validate If Table Cell Have The Expected Value    ${value}    

##  List  ##
Select Day from Days List By Position
    [Arguments]    ${position}
    Click on Element From List By Position    ${DAYSLOCATORINPUT}    ${position}  

Select Day from Days List  
    [Arguments]    ${value}
    Click on Element From List By Value    ${DAYSLOCATOR}    ${value}

Select Color 
    [Arguments]    ${value}   
    Select Value From List   ${COLORSLIST}    ${value} 

Select Country  
    [Arguments]    ${value}
    ${countryValues}=    Get List Items      ${GETCOUNTRYVALUES}
    [Return]    ${countryValues}  
    Select From List By Label    ${GETCOUNTRYVALUES}    ${value}

Select Page from Table Pages
    [Arguments]    ${pageNumber}
    Change Page In Pagination Table    ${PAGINATIONTABLEPAGE}    ${pageNumber}

Mark checkbox based on value in Table
    [Arguments]    ${value}
    Toggle Checkbox Based on Value in Table    ${PAGINATIONTABLE}   ${value}    ${TDPOSITION}