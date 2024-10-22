*** Setting ***
Library     Browser

*** Variable ***
${BROWSER}      chromium
${HEADLESS}        true


*** Test Cases ***
Create Quote for Car
    Open insurance Application
    Enter Vehicle Data for Automobile
    Enter Insurant Data
    Enter Product Data
    Select Price Option
    Send Quote
    End Test

*** Keywords ***
Open Insurance Application
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context    locale=en-GB
    New Page        https://sampleapp.tricentis.com

Enter Vehicle Data for Automobile
    Click       div.main-navigation >> "Automobile"
    Select Options By   id=make     text    Audi
    Fill Text       id=engineperformance    110
    Fill Text       id=dateofmanufacture    06/12/1980
    Select Options By   id=numberofseats    text    5
    Select Options By   id=fuel     text    Petrol
    Fill Text       id=listprice    30000
    Fill Text       id=annualmileage    10000
    Click        section[style="display: block;"] >> text=Next 

Enter Insurant Data
    [Arguments]    ${firstname}=Mike    ${lastname}=Tyson
    Fill Text        id=firstname    Mike
    Fill Text        id=lastname    Tyson
    Check Checkbox    *css=label >> id=gendermale
    Fill Text        id=streetaddress    Test    streetaddress
    Select Options By        id=country    text    Finland
    Fill Text        id=zipcode    003587
    Fill Text        id=city       Oulu
    Select Options By        id=occupation    text    Employee
    Click    text=Lake Diving
    Click        section[style="display: block;"] >> text=Next

Enter Product Data
    Fill Text    id=startdate    06/01/2023
    Select Options By    id=insurancesum    text    7.000.000,00
    Select Options By    id=meritrating    text    Bonus 1
    Select Options By    id=damageinsurance    text    No Coverage
    Check Checkbox    *css=label >> id=EuroProtection
    Select Options By    id=courtesycar    text    Yes
    Click    section[style="display: block;"] >> text=Next »

Select Price Option
    [Arguments]    ${price_option}=Silver
    Click    *css=label >> css=[value=${price_option}]
    Click    section[style="display: block;"] >> text=Next »

Send Quote
    Fill Text    "E-Mail" >> .. >> input    max.mustermann@example.com
    Fill Text    "Phone" >> .. >> input    0049201123456
    Fill Text    "Username" >> .. >> input    max.mustermann
    Fill Text    "Password" >> .. >> input    SecretPassword123!
    Fill Text    "Confirm Password" >> .. >> input    SecretPassword123!
    Fill Text    "Comments" >> .. >> textarea    Some comments
    ${promise}=     Promise To    Wait For Response     matcher=http://sampleapp.tricentis.com/101/tcpdf/pdfs/quote.php     timeout=10
    Click    "« Send »"
    ${body}=    Wait For    ${promise}
    Log    ${body}[status]
    Log    ${body}[body]
    Wait For Elements State    "Sending e-mail success!"
    Click    "OK"

End Test
    Close Context
    Close Browser
