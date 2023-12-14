*** Settings ***
Documentation      Basic tests
Library            SeleniumLibrary
Library            Collections
Library            DateTime
Resource           ../Resources/common.resource

*** Variables ***
${NAMEID}                      id=name
${EMAILID}                     id=email
${PHONEID}                     id=phone
${GENDEROPTIONS}               gender
${CHECKBOXSUNDAY}              id=sunday
${CHECKBOXTHURSDAY}            id=thursday
${TABLELOCATOR}                xpath://table[@name='BookTable']
${ROWCOUNT}                    xpath://table[@name='BookTable']/tbody/tr
${COLCOUNT}                    xpath://table[@name='BookTable']/tbody/tr[1]/th
${PAGINATIONTABLEHEADER}       xpath://*[@id="productTable"]/thead
${PAGINATIONTABLE}             xpath://table[@id="productTable"]
${PAGINATIONTABLECHECKBOX}     xpath://*[@id="productTable"]/tbody/tr[4]/td[4]/input
${GETCOUNTRYVALUES}            id=country
${ABTESTINGLINK}               //*[@id="content"]/ul/li[1]/a

${USERNAME}                Testing Name 
${EMAIL}                   useremail@test.com
${PHONE}                   198234568
${MALERADIO}               Male

*** Test Cases ***
Test Open Browser and Input Information
...    [Documentation]  Try to input name, email and phone number
       [Tags]  Testing input and variables
       #Open browser and enter basic information
       Open Browser    https://testautomationpractice.blogspot.com    chrome
       Maximize Browser Window
       Enter information    ${NAMEID}  ${USERNAME}  
       Enter information    ${EMAILID}  ${EMAIL}
       Enter information    ${PHONEID}  ${PHONE}

       #Select gender radio button
       Select Radio Option    ${GENDEROPTIONS}        male

       #Select or unselect checkbox
       Select or unselect checkbox    ${CHECKBOXSUNDAY}
       Select or unselect checkbox    ${CHECKBOXTHURSDAY}   

Test Tables
       Row count    ${TABLELOCATOR}
       Column count    ${TABLELOCATOR} 

       Click on Header    ${PAGINATIONTABLEHEADER}  

       Header should contain    ${TABLELOCATOR}   BookName

       Get Table Cell   ${PAGINATIONTABLE}    2    4

       Click Element    ${PAGINATIONTABLECHECKBOX}

Test Lists
    
       ${countryValues}=    Get List Items      ${GETCOUNTRYVALUES}
       Log List    ${countryValues}

       List Should Contain Value    ${countryValues}    Brazil

       Append To List    ${countryValues}    Panama
       Log List    ${countryValues}

       List Should Contain Value    ${countryValues}    Panama

       Select Item From List With Index    ${GETCOUNTRYVALUES}   9
       Append To List    ${countryValues}    Panama
       Log List    ${countryValues}

       Remove From List    ${countryValues}    11
       Log List    ${countryValues}

       Verify Duplicated Elements in List    ${countryValues}

Test Navigate To Another Page
       Go To        https://the-internet.herokuapp.com/
       Wait Until Element Contains        ${ABTESTINGLINK}        A/B Testing
       Page Should Contain Link    ${ABTESTINGLINK}
       Click Element    ${ABTESTINGLINK}
        
       Wait Until Page Contains    A/B Test  
       

        

        



