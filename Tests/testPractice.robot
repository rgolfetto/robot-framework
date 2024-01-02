*** Settings ***
Documentation      Basic tests
Library            SeleniumLibrary
Library            Collections
Library            DateTime
Resource          ../Resources/Page Objects/AutomationPractice_PageObject.resource
Resource          ../Resources/TestData.resource

*** Test Cases ***
Test Open Browser and Input Information
...    [Documentation]  Basic test automation 
       [Tags]  AB
       Open Browser, Maximize and navigate to URL

       ##Insert name, email, phone, address
       Enter name             Testing Test Name
       Enter email            useremail@test.com
       Enter phone number     198234568
       Enter address          St Street, 30, 250100
        
       ##Select gender option (male or female)
       Select Gender          male

       #Select Country
       Select Country         Brazil
       
       #Select Day By Position
       Select Day from Days List By Position    1

       #Select Day By Value(name)
       Select Day from Days List    Tuesday

       #Select Color from List
       Select Color     Yellow

       #Get WebTable value by Position
       Validate If Table Cell Have Any Value In Selected Row and Column    7    1 

       #Get WebTable Cell by Value
       Validate If Table Cell Have The Especified Value   Javascript

       #Select page from pagination table by adding the page number
       Select Page from Table Pages    3

       #Mark checkbox based on line value
       Mark checkbox based on value in Table    Product 14

       #Click the submit button
       Click Submit
       

        

        



